From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/8] i2c: break out smbus support into seperate file
Date: Fri, 26 May 2017 10:20:54 +0200
Message-ID: <20170526082101.4746-4-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Break out the exported SMBus functions and the emulation layer into a
seperate file. This also involved splitting up the tracing header into
an I2C and an SMBus part.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/driver-api/i2c.rst |   3 +
 drivers/i2c/Makefile             |   2 +-
 drivers/i2c/i2c-core-base.c      | 574 -------------------------------------
 drivers/i2c/i2c-core-smbus.c     | 594 +++++++++++++++++++++++++++++++++++++++
 include/trace/events/i2c.h       | 226 +--------------
 include/trace/events/smbus.h     | 249 ++++++++++++++++
 6 files changed, 849 insertions(+), 799 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-smbus.c
 create mode 100644 include/trace/events/smbus.h

diff --git a/Documentation/driver-api/i2c.rst b/Documentation/driver-api/i2c.rst
index 67366d9ff7303f..7582c079d74795 100644
--- a/Documentation/driver-api/i2c.rst
+++ b/Documentation/driver-api/i2c.rst
@@ -43,3 +43,6 @@ i2c_adapter devices which don't support those I2C operations.
 
 .. kernel-doc:: drivers/i2c/i2c-core-base.c
    :export:
+
+.. kernel-doc:: drivers/i2c/i2c-core-smbus.c
+   :export:
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 6c54716e7f28ca..a6a90fe2db887a 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
-i2c-core-objs 			:= i2c-core-base.o
+i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 88c0ca664a7b8f..70fc4624c69c25 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -14,9 +14,6 @@
 /* ------------------------------------------------------------------------- */
 
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
-   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
-   SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com> and
-   Jean Delvare <jdelvare@suse.de>
    Mux support by Rodolfo Giometti <giometti@enneenne.com> and
    Michael Lawnick <michael.lawnick.ext@nsn.com>
    OF support is copyright (c) 2008 Jochen Friedrich <jochen@scram.de>
@@ -3155,577 +3152,6 @@ void i2c_put_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
-/* The SMBus parts */
-
-#define POLY    (0x1070U << 3)
-static u8 crc8(u16 data)
-{
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		if (data & 0x8000)
-			data = data ^ POLY;
-		data = data << 1;
-	}
-	return (u8)(data >> 8);
-}
-
-/* Incremental CRC8 over count bytes in the array pointed to by p */
-static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
-{
-	int i;
-
-	for (i = 0; i < count; i++)
-		crc = crc8((crc ^ p[i]) << 8);
-	return crc;
-}
-
-/* Assume a 7-bit address, which is reasonable for SMBus */
-static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
-{
-	/* The address will be sent first */
-	u8 addr = i2c_8bit_addr_from_msg(msg);
-	pec = i2c_smbus_pec(pec, &addr, 1);
-
-	/* The data buffer follows */
-	return i2c_smbus_pec(pec, msg->buf, msg->len);
-}
-
-/* Used for write only transactions */
-static inline void i2c_smbus_add_pec(struct i2c_msg *msg)
-{
-	msg->buf[msg->len] = i2c_smbus_msg_pec(0, msg);
-	msg->len++;
-}
-
-/* Return <0 on CRC error
-   If there was a write before this read (most cases) we need to take the
-   partial CRC from the write part into account.
-   Note that this function does modify the message (we need to decrease the
-   message length to hide the CRC byte from the caller). */
-static int i2c_smbus_check_pec(u8 cpec, struct i2c_msg *msg)
-{
-	u8 rpec = msg->buf[--msg->len];
-	cpec = i2c_smbus_msg_pec(cpec, msg);
-
-	if (rpec != cpec) {
-		pr_debug("Bad PEC 0x%02x vs. 0x%02x\n",
-			rpec, cpec);
-		return -EBADMSG;
-	}
-	return 0;
-}
-
-/**
- * i2c_smbus_read_byte - SMBus "receive byte" protocol
- * @client: Handle to slave device
- *
- * This executes the SMBus "receive byte" protocol, returning negative errno
- * else the byte received from the device.
- */
-s32 i2c_smbus_read_byte(const struct i2c_client *client)
-{
-	union i2c_smbus_data data;
-	int status;
-
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_READ, 0,
-				I2C_SMBUS_BYTE, &data);
-	return (status < 0) ? status : data.byte;
-}
-EXPORT_SYMBOL(i2c_smbus_read_byte);
-
-/**
- * i2c_smbus_write_byte - SMBus "send byte" protocol
- * @client: Handle to slave device
- * @value: Byte to be sent
- *
- * This executes the SMBus "send byte" protocol, returning negative errno
- * else zero on success.
- */
-s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
-{
-	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
-}
-EXPORT_SYMBOL(i2c_smbus_write_byte);
-
-/**
- * i2c_smbus_read_byte_data - SMBus "read byte" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- *
- * This executes the SMBus "read byte" protocol, returning negative errno
- * else a data byte received from the device.
- */
-s32 i2c_smbus_read_byte_data(const struct i2c_client *client, u8 command)
-{
-	union i2c_smbus_data data;
-	int status;
-
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_READ, command,
-				I2C_SMBUS_BYTE_DATA, &data);
-	return (status < 0) ? status : data.byte;
-}
-EXPORT_SYMBOL(i2c_smbus_read_byte_data);
-
-/**
- * i2c_smbus_write_byte_data - SMBus "write byte" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @value: Byte being written
- *
- * This executes the SMBus "write byte" protocol, returning negative errno
- * else zero on success.
- */
-s32 i2c_smbus_write_byte_data(const struct i2c_client *client, u8 command,
-			      u8 value)
-{
-	union i2c_smbus_data data;
-	data.byte = value;
-	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-			      I2C_SMBUS_WRITE, command,
-			      I2C_SMBUS_BYTE_DATA, &data);
-}
-EXPORT_SYMBOL(i2c_smbus_write_byte_data);
-
-/**
- * i2c_smbus_read_word_data - SMBus "read word" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- *
- * This executes the SMBus "read word" protocol, returning negative errno
- * else a 16-bit unsigned "word" received from the device.
- */
-s32 i2c_smbus_read_word_data(const struct i2c_client *client, u8 command)
-{
-	union i2c_smbus_data data;
-	int status;
-
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_READ, command,
-				I2C_SMBUS_WORD_DATA, &data);
-	return (status < 0) ? status : data.word;
-}
-EXPORT_SYMBOL(i2c_smbus_read_word_data);
-
-/**
- * i2c_smbus_write_word_data - SMBus "write word" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @value: 16-bit "word" being written
- *
- * This executes the SMBus "write word" protocol, returning negative errno
- * else zero on success.
- */
-s32 i2c_smbus_write_word_data(const struct i2c_client *client, u8 command,
-			      u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-			      I2C_SMBUS_WRITE, command,
-			      I2C_SMBUS_WORD_DATA, &data);
-}
-EXPORT_SYMBOL(i2c_smbus_write_word_data);
-
-/**
- * i2c_smbus_read_block_data - SMBus "block read" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @values: Byte array into which data will be read; big enough to hold
- *	the data returned by the slave.  SMBus allows at most 32 bytes.
- *
- * This executes the SMBus "block read" protocol, returning negative errno
- * else the number of data bytes in the slave's response.
- *
- * Note that using this function requires that the client's adapter support
- * the I2C_FUNC_SMBUS_READ_BLOCK_DATA functionality.  Not all adapter drivers
- * support this; its emulation through I2C messaging relies on a specific
- * mechanism (I2C_M_RECV_LEN) which may not be implemented.
- */
-s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
-			      u8 *values)
-{
-	union i2c_smbus_data data;
-	int status;
-
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_READ, command,
-				I2C_SMBUS_BLOCK_DATA, &data);
-	if (status)
-		return status;
-
-	memcpy(values, &data.block[1], data.block[0]);
-	return data.block[0];
-}
-EXPORT_SYMBOL(i2c_smbus_read_block_data);
-
-/**
- * i2c_smbus_write_block_data - SMBus "block write" protocol
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @length: Size of data block; SMBus allows at most 32 bytes
- * @values: Byte array which will be written.
- *
- * This executes the SMBus "block write" protocol, returning negative errno
- * else zero on success.
- */
-s32 i2c_smbus_write_block_data(const struct i2c_client *client, u8 command,
-			       u8 length, const u8 *values)
-{
-	union i2c_smbus_data data;
-
-	if (length > I2C_SMBUS_BLOCK_MAX)
-		length = I2C_SMBUS_BLOCK_MAX;
-	data.block[0] = length;
-	memcpy(&data.block[1], values, length);
-	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-			      I2C_SMBUS_WRITE, command,
-			      I2C_SMBUS_BLOCK_DATA, &data);
-}
-EXPORT_SYMBOL(i2c_smbus_write_block_data);
-
-/* Returns the number of read bytes */
-s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
-				  u8 length, u8 *values)
-{
-	union i2c_smbus_data data;
-	int status;
-
-	if (length > I2C_SMBUS_BLOCK_MAX)
-		length = I2C_SMBUS_BLOCK_MAX;
-	data.block[0] = length;
-	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_READ, command,
-				I2C_SMBUS_I2C_BLOCK_DATA, &data);
-	if (status < 0)
-		return status;
-
-	memcpy(values, &data.block[1], data.block[0]);
-	return data.block[0];
-}
-EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
-
-s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client, u8 command,
-				   u8 length, const u8 *values)
-{
-	union i2c_smbus_data data;
-
-	if (length > I2C_SMBUS_BLOCK_MAX)
-		length = I2C_SMBUS_BLOCK_MAX;
-	data.block[0] = length;
-	memcpy(data.block + 1, values, length);
-	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-			      I2C_SMBUS_WRITE, command,
-			      I2C_SMBUS_I2C_BLOCK_DATA, &data);
-}
-EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
-
-/* Simulate a SMBus command using the i2c protocol
-   No checking of parameters is done!  */
-static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
-				   unsigned short flags,
-				   char read_write, u8 command, int size,
-				   union i2c_smbus_data *data)
-{
-	/* So we need to generate a series of msgs. In the case of writing, we
-	  need to use only one message; when reading, we need two. We initialize
-	  most things with sane defaults, to keep the code below somewhat
-	  simpler. */
-	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
-	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
-	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
-	int i;
-	u8 partial_pec = 0;
-	int status;
-	struct i2c_msg msg[2] = {
-		{
-			.addr = addr,
-			.flags = flags,
-			.len = 1,
-			.buf = msgbuf0,
-		}, {
-			.addr = addr,
-			.flags = flags | I2C_M_RD,
-			.len = 0,
-			.buf = msgbuf1,
-		},
-	};
-
-	msgbuf0[0] = command;
-	switch (size) {
-	case I2C_SMBUS_QUICK:
-		msg[0].len = 0;
-		/* Special case: The read/write field is used as data */
-		msg[0].flags = flags | (read_write == I2C_SMBUS_READ ?
-					I2C_M_RD : 0);
-		num = 1;
-		break;
-	case I2C_SMBUS_BYTE:
-		if (read_write == I2C_SMBUS_READ) {
-			/* Special case: only a read! */
-			msg[0].flags = I2C_M_RD | flags;
-			num = 1;
-		}
-		break;
-	case I2C_SMBUS_BYTE_DATA:
-		if (read_write == I2C_SMBUS_READ)
-			msg[1].len = 1;
-		else {
-			msg[0].len = 2;
-			msgbuf0[1] = data->byte;
-		}
-		break;
-	case I2C_SMBUS_WORD_DATA:
-		if (read_write == I2C_SMBUS_READ)
-			msg[1].len = 2;
-		else {
-			msg[0].len = 3;
-			msgbuf0[1] = data->word & 0xff;
-			msgbuf0[2] = data->word >> 8;
-		}
-		break;
-	case I2C_SMBUS_PROC_CALL:
-		num = 2; /* Special case */
-		read_write = I2C_SMBUS_READ;
-		msg[0].len = 3;
-		msg[1].len = 2;
-		msgbuf0[1] = data->word & 0xff;
-		msgbuf0[2] = data->word >> 8;
-		break;
-	case I2C_SMBUS_BLOCK_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			msg[1].flags |= I2C_M_RECV_LEN;
-			msg[1].len = 1; /* block length will be added by
-					   the underlying bus driver */
-		} else {
-			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
-			for (i = 1; i < msg[0].len; i++)
-				msgbuf0[i] = data->block[i-1];
-		}
-		break;
-	case I2C_SMBUS_BLOCK_PROC_CALL:
-		num = 2; /* Another special case */
-		read_write = I2C_SMBUS_READ;
-		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
-			dev_err(&adapter->dev,
-				"Invalid block write size %d\n",
-				data->block[0]);
-			return -EINVAL;
-		}
-		msg[0].len = data->block[0] + 2;
-		for (i = 1; i < msg[0].len; i++)
-			msgbuf0[i] = data->block[i-1];
-		msg[1].flags |= I2C_M_RECV_LEN;
-		msg[1].len = 1; /* block length will be added by
-				   the underlying bus driver */
-		break;
-	case I2C_SMBUS_I2C_BLOCK_DATA:
-		if (read_write == I2C_SMBUS_READ) {
-			msg[1].len = data->block[0];
-		} else {
-			msg[0].len = data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
-			for (i = 1; i <= data->block[0]; i++)
-				msgbuf0[i] = data->block[i];
-		}
-		break;
-	default:
-		dev_err(&adapter->dev, "Unsupported transaction %d\n", size);
-		return -EOPNOTSUPP;
-	}
-
-	i = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
-				      && size != I2C_SMBUS_I2C_BLOCK_DATA);
-	if (i) {
-		/* Compute PEC if first message is a write */
-		if (!(msg[0].flags & I2C_M_RD)) {
-			if (num == 1) /* Write only */
-				i2c_smbus_add_pec(&msg[0]);
-			else /* Write followed by read */
-				partial_pec = i2c_smbus_msg_pec(0, &msg[0]);
-		}
-		/* Ask for PEC if last message is a read */
-		if (msg[num-1].flags & I2C_M_RD)
-			msg[num-1].len++;
-	}
-
-	status = i2c_transfer(adapter, msg, num);
-	if (status < 0)
-		return status;
-
-	/* Check PEC if last message is a read */
-	if (i && (msg[num-1].flags & I2C_M_RD)) {
-		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
-		if (status < 0)
-			return status;
-	}
-
-	if (read_write == I2C_SMBUS_READ)
-		switch (size) {
-		case I2C_SMBUS_BYTE:
-			data->byte = msgbuf0[0];
-			break;
-		case I2C_SMBUS_BYTE_DATA:
-			data->byte = msgbuf1[0];
-			break;
-		case I2C_SMBUS_WORD_DATA:
-		case I2C_SMBUS_PROC_CALL:
-			data->word = msgbuf1[0] | (msgbuf1[1] << 8);
-			break;
-		case I2C_SMBUS_I2C_BLOCK_DATA:
-			for (i = 0; i < data->block[0]; i++)
-				data->block[i+1] = msgbuf1[i];
-			break;
-		case I2C_SMBUS_BLOCK_DATA:
-		case I2C_SMBUS_BLOCK_PROC_CALL:
-			for (i = 0; i < msgbuf1[0] + 1; i++)
-				data->block[i] = msgbuf1[i];
-			break;
-		}
-	return 0;
-}
-
-/**
- * i2c_smbus_xfer - execute SMBus protocol operations
- * @adapter: Handle to I2C bus
- * @addr: Address of SMBus slave on that bus
- * @flags: I2C_CLIENT_* flags (usually zero or I2C_CLIENT_PEC)
- * @read_write: I2C_SMBUS_READ or I2C_SMBUS_WRITE
- * @command: Byte interpreted by slave, for protocols which use such bytes
- * @protocol: SMBus protocol operation to execute, such as I2C_SMBUS_PROC_CALL
- * @data: Data to be read or written
- *
- * This executes an SMBus protocol operation, and returns a negative
- * errno code else zero on success.
- */
-s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
-		   char read_write, u8 command, int protocol,
-		   union i2c_smbus_data *data)
-{
-	unsigned long orig_jiffies;
-	int try;
-	s32 res;
-
-	/* If enabled, the following two tracepoints are conditional on
-	 * read_write and protocol.
-	 */
-	trace_smbus_write(adapter, addr, flags, read_write,
-			  command, protocol, data);
-	trace_smbus_read(adapter, addr, flags, read_write,
-			 command, protocol);
-
-	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
-
-	if (adapter->algo->smbus_xfer) {
-		i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
-
-		/* Retry automatically on arbitration loss */
-		orig_jiffies = jiffies;
-		for (res = 0, try = 0; try <= adapter->retries; try++) {
-			res = adapter->algo->smbus_xfer(adapter, addr, flags,
-							read_write, command,
-							protocol, data);
-			if (res != -EAGAIN)
-				break;
-			if (time_after(jiffies,
-				       orig_jiffies + adapter->timeout))
-				break;
-		}
-		i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
-
-		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
-			goto trace;
-		/*
-		 * Fall back to i2c_smbus_xfer_emulated if the adapter doesn't
-		 * implement native support for the SMBus operation.
-		 */
-	}
-
-	res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
-				      command, protocol, data);
-
-trace:
-	/* If enabled, the reply tracepoint is conditional on read_write. */
-	trace_smbus_reply(adapter, addr, flags, read_write,
-			  command, protocol, data);
-	trace_smbus_result(adapter, addr, flags, read_write,
-			   command, protocol, res);
-
-	return res;
-}
-EXPORT_SYMBOL(i2c_smbus_xfer);
-
-/**
- * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
- * @client: Handle to slave device
- * @command: Byte interpreted by slave
- * @length: Size of data block; SMBus allows at most I2C_SMBUS_BLOCK_MAX bytes
- * @values: Byte array into which data will be read; big enough to hold
- *	the data returned by the slave.  SMBus allows at most
- *	I2C_SMBUS_BLOCK_MAX bytes.
- *
- * This executes the SMBus "block read" protocol if supported by the adapter.
- * If block read is not supported, it emulates it using either word or byte
- * read protocols depending on availability.
- *
- * The addresses of the I2C slave device that are accessed with this function
- * must be mapped to a linear region, so that a block read will have the same
- * effect as a byte read. Before using this function you must double-check
- * if the I2C slave does support exchanging a block transfer with a byte
- * transfer.
- */
-s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
-					      u8 command, u8 length, u8 *values)
-{
-	u8 i = 0;
-	int status;
-
-	if (length > I2C_SMBUS_BLOCK_MAX)
-		length = I2C_SMBUS_BLOCK_MAX;
-
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
-		return i2c_smbus_read_i2c_block_data(client, command, length, values);
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA))
-		return -EOPNOTSUPP;
-
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)) {
-		while ((i + 2) <= length) {
-			status = i2c_smbus_read_word_data(client, command + i);
-			if (status < 0)
-				return status;
-			values[i] = status & 0xff;
-			values[i + 1] = status >> 8;
-			i += 2;
-		}
-	}
-
-	while (i < length) {
-		status = i2c_smbus_read_byte_data(client, command + i);
-		if (status < 0)
-			return status;
-		values[i] = status;
-		i++;
-	}
-
-	return i;
-}
-EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
-
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
new file mode 100644
index 00000000000000..10f00a82ec9dba
--- /dev/null
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -0,0 +1,594 @@
+/*
+ * Linux I2C core SMBus and SMBus emulation code
+ *
+ * This file contains the SMBus functions which are always included in the I2C
+ * core because they can be emulated via I2C. SMBus specific extensions
+ * (e.g. smbalert) are handled in a seperate i2c-smbus module.
+ *
+ * All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
+ * SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com> and
+ * Jean Delvare <jdelvare@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/smbus.h>
+
+
+/* The SMBus parts */
+
+#define POLY    (0x1070U << 3)
+static u8 crc8(u16 data)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		if (data & 0x8000)
+			data = data ^ POLY;
+		data = data << 1;
+	}
+	return (u8)(data >> 8);
+}
+
+/* Incremental CRC8 over count bytes in the array pointed to by p */
+static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		crc = crc8((crc ^ p[i]) << 8);
+	return crc;
+}
+
+/* Assume a 7-bit address, which is reasonable for SMBus */
+static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
+{
+	/* The address will be sent first */
+	u8 addr = i2c_8bit_addr_from_msg(msg);
+	pec = i2c_smbus_pec(pec, &addr, 1);
+
+	/* The data buffer follows */
+	return i2c_smbus_pec(pec, msg->buf, msg->len);
+}
+
+/* Used for write only transactions */
+static inline void i2c_smbus_add_pec(struct i2c_msg *msg)
+{
+	msg->buf[msg->len] = i2c_smbus_msg_pec(0, msg);
+	msg->len++;
+}
+
+/* Return <0 on CRC error
+   If there was a write before this read (most cases) we need to take the
+   partial CRC from the write part into account.
+   Note that this function does modify the message (we need to decrease the
+   message length to hide the CRC byte from the caller). */
+static int i2c_smbus_check_pec(u8 cpec, struct i2c_msg *msg)
+{
+	u8 rpec = msg->buf[--msg->len];
+	cpec = i2c_smbus_msg_pec(cpec, msg);
+
+	if (rpec != cpec) {
+		pr_debug("Bad PEC 0x%02x vs. 0x%02x\n",
+			rpec, cpec);
+		return -EBADMSG;
+	}
+	return 0;
+}
+
+/**
+ * i2c_smbus_read_byte - SMBus "receive byte" protocol
+ * @client: Handle to slave device
+ *
+ * This executes the SMBus "receive byte" protocol, returning negative errno
+ * else the byte received from the device.
+ */
+s32 i2c_smbus_read_byte(const struct i2c_client *client)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, 0,
+				I2C_SMBUS_BYTE, &data);
+	return (status < 0) ? status : data.byte;
+}
+EXPORT_SYMBOL(i2c_smbus_read_byte);
+
+/**
+ * i2c_smbus_write_byte - SMBus "send byte" protocol
+ * @client: Handle to slave device
+ * @value: Byte to be sent
+ *
+ * This executes the SMBus "send byte" protocol, returning negative errno
+ * else zero on success.
+ */
+s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
+{
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+	                      I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
+}
+EXPORT_SYMBOL(i2c_smbus_write_byte);
+
+/**
+ * i2c_smbus_read_byte_data - SMBus "read byte" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ *
+ * This executes the SMBus "read byte" protocol, returning negative errno
+ * else a data byte received from the device.
+ */
+s32 i2c_smbus_read_byte_data(const struct i2c_client *client, u8 command)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, command,
+				I2C_SMBUS_BYTE_DATA, &data);
+	return (status < 0) ? status : data.byte;
+}
+EXPORT_SYMBOL(i2c_smbus_read_byte_data);
+
+/**
+ * i2c_smbus_write_byte_data - SMBus "write byte" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @value: Byte being written
+ *
+ * This executes the SMBus "write byte" protocol, returning negative errno
+ * else zero on success.
+ */
+s32 i2c_smbus_write_byte_data(const struct i2c_client *client, u8 command,
+			      u8 value)
+{
+	union i2c_smbus_data data;
+	data.byte = value;
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_BYTE_DATA, &data);
+}
+EXPORT_SYMBOL(i2c_smbus_write_byte_data);
+
+/**
+ * i2c_smbus_read_word_data - SMBus "read word" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ *
+ * This executes the SMBus "read word" protocol, returning negative errno
+ * else a 16-bit unsigned "word" received from the device.
+ */
+s32 i2c_smbus_read_word_data(const struct i2c_client *client, u8 command)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, command,
+				I2C_SMBUS_WORD_DATA, &data);
+	return (status < 0) ? status : data.word;
+}
+EXPORT_SYMBOL(i2c_smbus_read_word_data);
+
+/**
+ * i2c_smbus_write_word_data - SMBus "write word" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @value: 16-bit "word" being written
+ *
+ * This executes the SMBus "write word" protocol, returning negative errno
+ * else zero on success.
+ */
+s32 i2c_smbus_write_word_data(const struct i2c_client *client, u8 command,
+			      u16 value)
+{
+	union i2c_smbus_data data;
+	data.word = value;
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_WORD_DATA, &data);
+}
+EXPORT_SYMBOL(i2c_smbus_write_word_data);
+
+/**
+ * i2c_smbus_read_block_data - SMBus "block read" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @values: Byte array into which data will be read; big enough to hold
+ *	the data returned by the slave.  SMBus allows at most 32 bytes.
+ *
+ * This executes the SMBus "block read" protocol, returning negative errno
+ * else the number of data bytes in the slave's response.
+ *
+ * Note that using this function requires that the client's adapter support
+ * the I2C_FUNC_SMBUS_READ_BLOCK_DATA functionality.  Not all adapter drivers
+ * support this; its emulation through I2C messaging relies on a specific
+ * mechanism (I2C_M_RECV_LEN) which may not be implemented.
+ */
+s32 i2c_smbus_read_block_data(const struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, command,
+				I2C_SMBUS_BLOCK_DATA, &data);
+	if (status)
+		return status;
+
+	memcpy(values, &data.block[1], data.block[0]);
+	return data.block[0];
+}
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
+
+/**
+ * i2c_smbus_write_block_data - SMBus "block write" protocol
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @length: Size of data block; SMBus allows at most 32 bytes
+ * @values: Byte array which will be written.
+ *
+ * This executes the SMBus "block write" protocol, returning negative errno
+ * else zero on success.
+ */
+s32 i2c_smbus_write_block_data(const struct i2c_client *client, u8 command,
+			       u8 length, const u8 *values)
+{
+	union i2c_smbus_data data;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	data.block[0] = length;
+	memcpy(&data.block[1], values, length);
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_BLOCK_DATA, &data);
+}
+EXPORT_SYMBOL(i2c_smbus_write_block_data);
+
+/* Returns the number of read bytes */
+s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client, u8 command,
+				  u8 length, u8 *values)
+{
+	union i2c_smbus_data data;
+	int status;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	data.block[0] = length;
+	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_READ, command,
+				I2C_SMBUS_I2C_BLOCK_DATA, &data);
+	if (status < 0)
+		return status;
+
+	memcpy(values, &data.block[1], data.block[0]);
+	return data.block[0];
+}
+EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+
+s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client, u8 command,
+				   u8 length, const u8 *values)
+{
+	union i2c_smbus_data data;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	data.block[0] = length;
+	memcpy(data.block + 1, values, length);
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_I2C_BLOCK_DATA, &data);
+}
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
+
+/* Simulate a SMBus command using the i2c protocol
+   No checking of parameters is done!  */
+static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
+				   unsigned short flags,
+				   char read_write, u8 command, int size,
+				   union i2c_smbus_data *data)
+{
+	/* So we need to generate a series of msgs. In the case of writing, we
+	  need to use only one message; when reading, we need two. We initialize
+	  most things with sane defaults, to keep the code below somewhat
+	  simpler. */
+	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
+	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
+	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
+	int i;
+	u8 partial_pec = 0;
+	int status;
+	struct i2c_msg msg[2] = {
+		{
+			.addr = addr,
+			.flags = flags,
+			.len = 1,
+			.buf = msgbuf0,
+		}, {
+			.addr = addr,
+			.flags = flags | I2C_M_RD,
+			.len = 0,
+			.buf = msgbuf1,
+		},
+	};
+
+	msgbuf0[0] = command;
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		msg[0].len = 0;
+		/* Special case: The read/write field is used as data */
+		msg[0].flags = flags | (read_write == I2C_SMBUS_READ ?
+					I2C_M_RD : 0);
+		num = 1;
+		break;
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_READ) {
+			/* Special case: only a read! */
+			msg[0].flags = I2C_M_RD | flags;
+			num = 1;
+		}
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		if (read_write == I2C_SMBUS_READ)
+			msg[1].len = 1;
+		else {
+			msg[0].len = 2;
+			msgbuf0[1] = data->byte;
+		}
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		if (read_write == I2C_SMBUS_READ)
+			msg[1].len = 2;
+		else {
+			msg[0].len = 3;
+			msgbuf0[1] = data->word & 0xff;
+			msgbuf0[2] = data->word >> 8;
+		}
+		break;
+	case I2C_SMBUS_PROC_CALL:
+		num = 2; /* Special case */
+		read_write = I2C_SMBUS_READ;
+		msg[0].len = 3;
+		msg[1].len = 2;
+		msgbuf0[1] = data->word & 0xff;
+		msgbuf0[2] = data->word >> 8;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_READ) {
+			msg[1].flags |= I2C_M_RECV_LEN;
+			msg[1].len = 1; /* block length will be added by
+					   the underlying bus driver */
+		} else {
+			msg[0].len = data->block[0] + 2;
+			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
+				dev_err(&adapter->dev,
+					"Invalid block write size %d\n",
+					data->block[0]);
+				return -EINVAL;
+			}
+			for (i = 1; i < msg[0].len; i++)
+				msgbuf0[i] = data->block[i-1];
+		}
+		break;
+	case I2C_SMBUS_BLOCK_PROC_CALL:
+		num = 2; /* Another special case */
+		read_write = I2C_SMBUS_READ;
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev,
+				"Invalid block write size %d\n",
+				data->block[0]);
+			return -EINVAL;
+		}
+		msg[0].len = data->block[0] + 2;
+		for (i = 1; i < msg[0].len; i++)
+			msgbuf0[i] = data->block[i-1];
+		msg[1].flags |= I2C_M_RECV_LEN;
+		msg[1].len = 1; /* block length will be added by
+				   the underlying bus driver */
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_READ) {
+			msg[1].len = data->block[0];
+		} else {
+			msg[0].len = data->block[0] + 1;
+			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
+				dev_err(&adapter->dev,
+					"Invalid block write size %d\n",
+					data->block[0]);
+				return -EINVAL;
+			}
+			for (i = 1; i <= data->block[0]; i++)
+				msgbuf0[i] = data->block[i];
+		}
+		break;
+	default:
+		dev_err(&adapter->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
+	}
+
+	i = ((flags & I2C_CLIENT_PEC) && size != I2C_SMBUS_QUICK
+				      && size != I2C_SMBUS_I2C_BLOCK_DATA);
+	if (i) {
+		/* Compute PEC if first message is a write */
+		if (!(msg[0].flags & I2C_M_RD)) {
+			if (num == 1) /* Write only */
+				i2c_smbus_add_pec(&msg[0]);
+			else /* Write followed by read */
+				partial_pec = i2c_smbus_msg_pec(0, &msg[0]);
+		}
+		/* Ask for PEC if last message is a read */
+		if (msg[num-1].flags & I2C_M_RD)
+			msg[num-1].len++;
+	}
+
+	status = i2c_transfer(adapter, msg, num);
+	if (status < 0)
+		return status;
+
+	/* Check PEC if last message is a read */
+	if (i && (msg[num-1].flags & I2C_M_RD)) {
+		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
+		if (status < 0)
+			return status;
+	}
+
+	if (read_write == I2C_SMBUS_READ)
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+			data->byte = msgbuf0[0];
+			break;
+		case I2C_SMBUS_BYTE_DATA:
+			data->byte = msgbuf1[0];
+			break;
+		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_PROC_CALL:
+			data->word = msgbuf1[0] | (msgbuf1[1] << 8);
+			break;
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			for (i = 0; i < data->block[0]; i++)
+				data->block[i+1] = msgbuf1[i];
+			break;
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+			for (i = 0; i < msgbuf1[0] + 1; i++)
+				data->block[i] = msgbuf1[i];
+			break;
+		}
+	return 0;
+}
+
+/**
+ * i2c_smbus_xfer - execute SMBus protocol operations
+ * @adapter: Handle to I2C bus
+ * @addr: Address of SMBus slave on that bus
+ * @flags: I2C_CLIENT_* flags (usually zero or I2C_CLIENT_PEC)
+ * @read_write: I2C_SMBUS_READ or I2C_SMBUS_WRITE
+ * @command: Byte interpreted by slave, for protocols which use such bytes
+ * @protocol: SMBus protocol operation to execute, such as I2C_SMBUS_PROC_CALL
+ * @data: Data to be read or written
+ *
+ * This executes an SMBus protocol operation, and returns a negative
+ * errno code else zero on success.
+ */
+s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
+		   char read_write, u8 command, int protocol,
+		   union i2c_smbus_data *data)
+{
+	unsigned long orig_jiffies;
+	int try;
+	s32 res;
+
+	/* If enabled, the following two tracepoints are conditional on
+	 * read_write and protocol.
+	 */
+	trace_smbus_write(adapter, addr, flags, read_write,
+			  command, protocol, data);
+	trace_smbus_read(adapter, addr, flags, read_write,
+			 command, protocol);
+
+	flags &= I2C_M_TEN | I2C_CLIENT_PEC | I2C_CLIENT_SCCB;
+
+	if (adapter->algo->smbus_xfer) {
+		i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
+
+		/* Retry automatically on arbitration loss */
+		orig_jiffies = jiffies;
+		for (res = 0, try = 0; try <= adapter->retries; try++) {
+			res = adapter->algo->smbus_xfer(adapter, addr, flags,
+							read_write, command,
+							protocol, data);
+			if (res != -EAGAIN)
+				break;
+			if (time_after(jiffies,
+				       orig_jiffies + adapter->timeout))
+				break;
+		}
+		i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
+
+		if (res != -EOPNOTSUPP || !adapter->algo->master_xfer)
+			goto trace;
+		/*
+		 * Fall back to i2c_smbus_xfer_emulated if the adapter doesn't
+		 * implement native support for the SMBus operation.
+		 */
+	}
+
+	res = i2c_smbus_xfer_emulated(adapter, addr, flags, read_write,
+				      command, protocol, data);
+
+trace:
+	/* If enabled, the reply tracepoint is conditional on read_write. */
+	trace_smbus_reply(adapter, addr, flags, read_write,
+			  command, protocol, data);
+	trace_smbus_result(adapter, addr, flags, read_write,
+			   command, protocol, res);
+
+	return res;
+}
+EXPORT_SYMBOL(i2c_smbus_xfer);
+
+/**
+ * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
+ * @client: Handle to slave device
+ * @command: Byte interpreted by slave
+ * @length: Size of data block; SMBus allows at most I2C_SMBUS_BLOCK_MAX bytes
+ * @values: Byte array into which data will be read; big enough to hold
+ *	the data returned by the slave.  SMBus allows at most
+ *	I2C_SMBUS_BLOCK_MAX bytes.
+ *
+ * This executes the SMBus "block read" protocol if supported by the adapter.
+ * If block read is not supported, it emulates it using either word or byte
+ * read protocols depending on availability.
+ *
+ * The addresses of the I2C slave device that are accessed with this function
+ * must be mapped to a linear region, so that a block read will have the same
+ * effect as a byte read. Before using this function you must double-check
+ * if the I2C slave does support exchanging a block transfer with a byte
+ * transfer.
+ */
+s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
+					      u8 command, u8 length, u8 *values)
+{
+	u8 i = 0;
+	int status;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return i2c_smbus_read_i2c_block_data(client, command, length, values);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		while ((i + 2) <= length) {
+			status = i2c_smbus_read_word_data(client, command + i);
+			if (status < 0)
+				return status;
+			values[i] = status & 0xff;
+			values[i + 1] = status >> 8;
+			i += 2;
+		}
+	}
+
+	while (i < length) {
+		status = i2c_smbus_read_byte_data(client, command + i);
+		if (status < 0)
+			return status;
+		values[i] = status;
+		i++;
+	}
+
+	return i;
+}
+EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
index 4abb8eab34d319..86a401190df9de 100644
--- a/include/trace/events/i2c.h
+++ b/include/trace/events/i2c.h
@@ -1,4 +1,4 @@
-/* I2C and SMBUS message transfer tracepoints
+/* I2C message transfer tracepoints
  *
  * Copyright (C) 2013 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -18,7 +18,7 @@
 #include <linux/tracepoint.h>
 
 /*
- * drivers/i2c/i2c-core.c
+ * drivers/i2c/i2c-core-base.c
  */
 extern int i2c_transfer_trace_reg(void);
 extern void i2c_transfer_trace_unreg(void);
@@ -144,228 +144,6 @@ TRACE_EVENT_FN(i2c_result,
 	       i2c_transfer_trace_reg,
 	       i2c_transfer_trace_unreg);
 
-/*
- * i2c_smbus_xfer() write data or procedure call request
- */
-TRACE_EVENT_CONDITION(smbus_write,
-	TP_PROTO(const struct i2c_adapter *adap,
-		 u16 addr, unsigned short flags,
-		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
-	TP_CONDITION(read_write == I2C_SMBUS_WRITE ||
-		     protocol == I2C_SMBUS_PROC_CALL ||
-		     protocol == I2C_SMBUS_BLOCK_PROC_CALL),
-	TP_STRUCT__entry(
-		__field(int,	adapter_nr		)
-		__field(__u16,	addr			)
-		__field(__u16,	flags			)
-		__field(__u8,	command			)
-		__field(__u8,	len			)
-		__field(__u32,	protocol		)
-		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
-	TP_fast_assign(
-		__entry->adapter_nr = adap->nr;
-		__entry->addr = addr;
-		__entry->flags = flags;
-		__entry->command = command;
-		__entry->protocol = protocol;
-
-		switch (protocol) {
-		case I2C_SMBUS_BYTE_DATA:
-			__entry->len = 1;
-			goto copy;
-		case I2C_SMBUS_WORD_DATA:
-		case I2C_SMBUS_PROC_CALL:
-			__entry->len = 2;
-			goto copy;
-		case I2C_SMBUS_BLOCK_DATA:
-		case I2C_SMBUS_BLOCK_PROC_CALL:
-		case I2C_SMBUS_I2C_BLOCK_DATA:
-			__entry->len = data->block[0] + 1;
-		copy:
-			memcpy(__entry->buf, data->block, __entry->len);
-			break;
-		case I2C_SMBUS_QUICK:
-		case I2C_SMBUS_BYTE:
-		case I2C_SMBUS_I2C_BLOCK_BROKEN:
-		default:
-			__entry->len = 0;
-		}
-		       ),
-	TP_printk("i2c-%d a=%03x f=%04x c=%x %s l=%u [%*phD]",
-		  __entry->adapter_nr,
-		  __entry->addr,
-		  __entry->flags,
-		  __entry->command,
-		  __print_symbolic(__entry->protocol,
-				   { I2C_SMBUS_QUICK,		"QUICK"	},
-				   { I2C_SMBUS_BYTE,		"BYTE"	},
-				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
-				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
-				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
-				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
-				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
-				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
-				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
-		  __entry->len,
-		  __entry->len, __entry->buf
-		  ));
-
-/*
- * i2c_smbus_xfer() read data request
- */
-TRACE_EVENT_CONDITION(smbus_read,
-	TP_PROTO(const struct i2c_adapter *adap,
-		 u16 addr, unsigned short flags,
-		 char read_write, u8 command, int protocol),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol),
-	TP_CONDITION(!(read_write == I2C_SMBUS_WRITE ||
-		       protocol == I2C_SMBUS_PROC_CALL ||
-		       protocol == I2C_SMBUS_BLOCK_PROC_CALL)),
-	TP_STRUCT__entry(
-		__field(int,	adapter_nr		)
-		__field(__u16,	flags			)
-		__field(__u16,	addr			)
-		__field(__u8,	command			)
-		__field(__u32,	protocol		)
-		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
-	TP_fast_assign(
-		__entry->adapter_nr = adap->nr;
-		__entry->addr = addr;
-		__entry->flags = flags;
-		__entry->command = command;
-		__entry->protocol = protocol;
-		       ),
-	TP_printk("i2c-%d a=%03x f=%04x c=%x %s",
-		  __entry->adapter_nr,
-		  __entry->addr,
-		  __entry->flags,
-		  __entry->command,
-		  __print_symbolic(__entry->protocol,
-				   { I2C_SMBUS_QUICK,		"QUICK"	},
-				   { I2C_SMBUS_BYTE,		"BYTE"	},
-				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
-				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
-				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
-				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
-				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
-				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
-				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" })
-		  ));
-
-/*
- * i2c_smbus_xfer() read data or procedure call reply
- */
-TRACE_EVENT_CONDITION(smbus_reply,
-	TP_PROTO(const struct i2c_adapter *adap,
-		 u16 addr, unsigned short flags,
-		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
-	TP_CONDITION(read_write == I2C_SMBUS_READ),
-	TP_STRUCT__entry(
-		__field(int,	adapter_nr		)
-		__field(__u16,	addr			)
-		__field(__u16,	flags			)
-		__field(__u8,	command			)
-		__field(__u8,	len			)
-		__field(__u32,	protocol		)
-		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
-	TP_fast_assign(
-		__entry->adapter_nr = adap->nr;
-		__entry->addr = addr;
-		__entry->flags = flags;
-		__entry->command = command;
-		__entry->protocol = protocol;
-
-		switch (protocol) {
-		case I2C_SMBUS_BYTE:
-		case I2C_SMBUS_BYTE_DATA:
-			__entry->len = 1;
-			goto copy;
-		case I2C_SMBUS_WORD_DATA:
-		case I2C_SMBUS_PROC_CALL:
-			__entry->len = 2;
-			goto copy;
-		case I2C_SMBUS_BLOCK_DATA:
-		case I2C_SMBUS_BLOCK_PROC_CALL:
-		case I2C_SMBUS_I2C_BLOCK_DATA:
-			__entry->len = data->block[0] + 1;
-		copy:
-			memcpy(__entry->buf, data->block, __entry->len);
-			break;
-		case I2C_SMBUS_QUICK:
-		case I2C_SMBUS_I2C_BLOCK_BROKEN:
-		default:
-			__entry->len = 0;
-		}
-		       ),
-	TP_printk("i2c-%d a=%03x f=%04x c=%x %s l=%u [%*phD]",
-		  __entry->adapter_nr,
-		  __entry->addr,
-		  __entry->flags,
-		  __entry->command,
-		  __print_symbolic(__entry->protocol,
-				   { I2C_SMBUS_QUICK,		"QUICK"	},
-				   { I2C_SMBUS_BYTE,		"BYTE"	},
-				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
-				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
-				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
-				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
-				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
-				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
-				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
-		  __entry->len,
-		  __entry->len, __entry->buf
-		  ));
-
-/*
- * i2c_smbus_xfer() result
- */
-TRACE_EVENT(smbus_result,
-	    TP_PROTO(const struct i2c_adapter *adap,
-		     u16 addr, unsigned short flags,
-		     char read_write, u8 command, int protocol,
-		     int res),
-	    TP_ARGS(adap, addr, flags, read_write, command, protocol, res),
-	    TP_STRUCT__entry(
-		    __field(int,	adapter_nr		)
-		    __field(__u16,	addr			)
-		    __field(__u16,	flags			)
-		    __field(__u8,	read_write		)
-		    __field(__u8,	command			)
-		    __field(__s16,	res			)
-		    __field(__u32,	protocol		)
-			     ),
-	    TP_fast_assign(
-		    __entry->adapter_nr = adap->nr;
-		    __entry->addr = addr;
-		    __entry->flags = flags;
-		    __entry->read_write = read_write;
-		    __entry->command = command;
-		    __entry->protocol = protocol;
-		    __entry->res = res;
-			   ),
-	    TP_printk("i2c-%d a=%03x f=%04x c=%x %s %s res=%d",
-		      __entry->adapter_nr,
-		      __entry->addr,
-		      __entry->flags,
-		      __entry->command,
-		      __print_symbolic(__entry->protocol,
-				       { I2C_SMBUS_QUICK,		"QUICK"	},
-				       { I2C_SMBUS_BYTE,		"BYTE"	},
-				       { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
-				       { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
-				       { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
-				       { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
-				       { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
-				       { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
-				       { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
-		      __entry->read_write == I2C_SMBUS_WRITE ? "wr" : "rd",
-		      __entry->res
-		      ));
-
 #endif /* _TRACE_I2C_H */
 
 /* This part must be outside protection */
diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
new file mode 100644
index 00000000000000..d2fb6e1d3e10a2
--- /dev/null
+++ b/include/trace/events/smbus.h
@@ -0,0 +1,249 @@
+/* SMBUS message transfer tracepoints
+ *
+ * Copyright (C) 2013 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM smbus
+
+#if !defined(_TRACE_SMBUS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SMBUS_H
+
+#include <linux/i2c.h>
+#include <linux/tracepoint.h>
+
+/*
+ * drivers/i2c/i2c-core-smbus.c
+ */
+
+/*
+ * i2c_smbus_xfer() write data or procedure call request
+ */
+TRACE_EVENT_CONDITION(smbus_write,
+	TP_PROTO(const struct i2c_adapter *adap,
+		 u16 addr, unsigned short flags,
+		 char read_write, u8 command, int protocol,
+		 const union i2c_smbus_data *data),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
+	TP_CONDITION(read_write == I2C_SMBUS_WRITE ||
+		     protocol == I2C_SMBUS_PROC_CALL ||
+		     protocol == I2C_SMBUS_BLOCK_PROC_CALL),
+	TP_STRUCT__entry(
+		__field(int,	adapter_nr		)
+		__field(__u16,	addr			)
+		__field(__u16,	flags			)
+		__field(__u8,	command			)
+		__field(__u8,	len			)
+		__field(__u32,	protocol		)
+		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
+	TP_fast_assign(
+		__entry->adapter_nr = adap->nr;
+		__entry->addr = addr;
+		__entry->flags = flags;
+		__entry->command = command;
+		__entry->protocol = protocol;
+
+		switch (protocol) {
+		case I2C_SMBUS_BYTE_DATA:
+			__entry->len = 1;
+			goto copy;
+		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_PROC_CALL:
+			__entry->len = 2;
+			goto copy;
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			__entry->len = data->block[0] + 1;
+		copy:
+			memcpy(__entry->buf, data->block, __entry->len);
+			break;
+		case I2C_SMBUS_QUICK:
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_I2C_BLOCK_BROKEN:
+		default:
+			__entry->len = 0;
+		}
+		       ),
+	TP_printk("i2c-%d a=%03x f=%04x c=%x %s l=%u [%*phD]",
+		  __entry->adapter_nr,
+		  __entry->addr,
+		  __entry->flags,
+		  __entry->command,
+		  __print_symbolic(__entry->protocol,
+				   { I2C_SMBUS_QUICK,		"QUICK"	},
+				   { I2C_SMBUS_BYTE,		"BYTE"	},
+				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
+				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
+				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
+				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
+				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
+				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
+				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
+		  __entry->len,
+		  __entry->len, __entry->buf
+		  ));
+
+/*
+ * i2c_smbus_xfer() read data request
+ */
+TRACE_EVENT_CONDITION(smbus_read,
+	TP_PROTO(const struct i2c_adapter *adap,
+		 u16 addr, unsigned short flags,
+		 char read_write, u8 command, int protocol),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol),
+	TP_CONDITION(!(read_write == I2C_SMBUS_WRITE ||
+		       protocol == I2C_SMBUS_PROC_CALL ||
+		       protocol == I2C_SMBUS_BLOCK_PROC_CALL)),
+	TP_STRUCT__entry(
+		__field(int,	adapter_nr		)
+		__field(__u16,	flags			)
+		__field(__u16,	addr			)
+		__field(__u8,	command			)
+		__field(__u32,	protocol		)
+		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
+	TP_fast_assign(
+		__entry->adapter_nr = adap->nr;
+		__entry->addr = addr;
+		__entry->flags = flags;
+		__entry->command = command;
+		__entry->protocol = protocol;
+		       ),
+	TP_printk("i2c-%d a=%03x f=%04x c=%x %s",
+		  __entry->adapter_nr,
+		  __entry->addr,
+		  __entry->flags,
+		  __entry->command,
+		  __print_symbolic(__entry->protocol,
+				   { I2C_SMBUS_QUICK,		"QUICK"	},
+				   { I2C_SMBUS_BYTE,		"BYTE"	},
+				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
+				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
+				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
+				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
+				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
+				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
+				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" })
+		  ));
+
+/*
+ * i2c_smbus_xfer() read data or procedure call reply
+ */
+TRACE_EVENT_CONDITION(smbus_reply,
+	TP_PROTO(const struct i2c_adapter *adap,
+		 u16 addr, unsigned short flags,
+		 char read_write, u8 command, int protocol,
+		 const union i2c_smbus_data *data),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
+	TP_CONDITION(read_write == I2C_SMBUS_READ),
+	TP_STRUCT__entry(
+		__field(int,	adapter_nr		)
+		__field(__u16,	addr			)
+		__field(__u16,	flags			)
+		__field(__u8,	command			)
+		__field(__u8,	len			)
+		__field(__u32,	protocol		)
+		__array(__u8, buf, I2C_SMBUS_BLOCK_MAX + 2)	),
+	TP_fast_assign(
+		__entry->adapter_nr = adap->nr;
+		__entry->addr = addr;
+		__entry->flags = flags;
+		__entry->command = command;
+		__entry->protocol = protocol;
+
+		switch (protocol) {
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_BYTE_DATA:
+			__entry->len = 1;
+			goto copy;
+		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_PROC_CALL:
+			__entry->len = 2;
+			goto copy;
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_PROC_CALL:
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			__entry->len = data->block[0] + 1;
+		copy:
+			memcpy(__entry->buf, data->block, __entry->len);
+			break;
+		case I2C_SMBUS_QUICK:
+		case I2C_SMBUS_I2C_BLOCK_BROKEN:
+		default:
+			__entry->len = 0;
+		}
+		       ),
+	TP_printk("i2c-%d a=%03x f=%04x c=%x %s l=%u [%*phD]",
+		  __entry->adapter_nr,
+		  __entry->addr,
+		  __entry->flags,
+		  __entry->command,
+		  __print_symbolic(__entry->protocol,
+				   { I2C_SMBUS_QUICK,		"QUICK"	},
+				   { I2C_SMBUS_BYTE,		"BYTE"	},
+				   { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
+				   { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
+				   { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
+				   { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
+				   { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
+				   { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
+				   { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
+		  __entry->len,
+		  __entry->len, __entry->buf
+		  ));
+
+/*
+ * i2c_smbus_xfer() result
+ */
+TRACE_EVENT(smbus_result,
+	    TP_PROTO(const struct i2c_adapter *adap,
+		     u16 addr, unsigned short flags,
+		     char read_write, u8 command, int protocol,
+		     int res),
+	    TP_ARGS(adap, addr, flags, read_write, command, protocol, res),
+	    TP_STRUCT__entry(
+		    __field(int,	adapter_nr		)
+		    __field(__u16,	addr			)
+		    __field(__u16,	flags			)
+		    __field(__u8,	read_write		)
+		    __field(__u8,	command			)
+		    __field(__s16,	res			)
+		    __field(__u32,	protocol		)
+			     ),
+	    TP_fast_assign(
+		    __entry->adapter_nr = adap->nr;
+		    __entry->addr = addr;
+		    __entry->flags = flags;
+		    __entry->read_write = read_write;
+		    __entry->command = command;
+		    __entry->protocol = protocol;
+		    __entry->res = res;
+			   ),
+	    TP_printk("i2c-%d a=%03x f=%04x c=%x %s %s res=%d",
+		      __entry->adapter_nr,
+		      __entry->addr,
+		      __entry->flags,
+		      __entry->command,
+		      __print_symbolic(__entry->protocol,
+				       { I2C_SMBUS_QUICK,		"QUICK"	},
+				       { I2C_SMBUS_BYTE,		"BYTE"	},
+				       { I2C_SMBUS_BYTE_DATA,		"BYTE_DATA" },
+				       { I2C_SMBUS_WORD_DATA,		"WORD_DATA" },
+				       { I2C_SMBUS_PROC_CALL,		"PROC_CALL" },
+				       { I2C_SMBUS_BLOCK_DATA,		"BLOCK_DATA" },
+				       { I2C_SMBUS_I2C_BLOCK_BROKEN,	"I2C_BLOCK_BROKEN" },
+				       { I2C_SMBUS_BLOCK_PROC_CALL,	"BLOCK_PROC_CALL" },
+				       { I2C_SMBUS_I2C_BLOCK_DATA,	"I2C_BLOCK_DATA" }),
+		      __entry->read_write == I2C_SMBUS_WRITE ? "wr" : "rd",
+		      __entry->res
+		      ));
+
+#endif /* _TRACE_SMBUS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.11.0

