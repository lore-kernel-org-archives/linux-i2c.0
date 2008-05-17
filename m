From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-rc1] i2c: kerneldoc for most i/o calls
Date: Sat, 17 May 2008 14:20:11 +0200
Message-ID: <20080517142011.1493e584@hyperion.delvare>
References: <200805031751.26920.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805031751.26920.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sat, 3 May 2008 17:51:26 -0700, David Brownell wrote:
> Provide kerneldoc for most of the I2C and SMBus I/O calls.  Add a
> summarizing some fault reporting issues which affect the ability to
> provide clean fault reports through I2C master transfer calls.

There's a word or two missing somewhere in that sentence.

> (Making it hard to precisely specify their return values...)
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> NOTE:  depends on the previous patch which stops the bogus returns
> of "-1" instead of real errno values.
> 
>  drivers/i2c/i2c-core.c |  156 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 145 insertions(+), 11 deletions(-)
> 
> --- g26.orig/drivers/i2c/i2c-core.c	2008-05-03 14:58:08.000000000 -0700
> +++ g26/drivers/i2c/i2c-core.c	2008-05-03 17:35:19.000000000 -0700
> @@ -1098,10 +1098,43 @@ module_exit(i2c_exit);
>   * ----------------------------------------------------
>   */
>  
> +/**
> + * i2c_transfer - execute a single or combined I2C message
> + * @adap: Identifies an I2C bus

For client, you use "Handle to slave device", so maybe for consistency
adap would be "Handle to I2C bus"?

> + * @msgs: One or more messages to execute before STOP is issued to
> + *	terminate the operation; each message begins with a START.
> + * @num: Number of messages to be executed.
> + *
> + * Returns negative errno, else the number of messages executed.
> + *
> + * Note that there is no requirement that each message be sent to
> + * the same slave address, although that is the most common model.
> + */
>  int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg *msgs, int num)
>  {
>  	int ret;
>  
> +	/* REVISIT the fault reporting model here is weak:
> +	 *
> +	 *  - When we get an error after receiving N bytes from a slave,
> +	 *    there is no way to report "N".
> +	 *
> +	 *  - When we get a NAK after transmitting N bytes to a slave,
> +	 *    there is no way to report "N" ... or to let the master
> +	 *    continue executing the rest of this combined message, if
> +	 *    that's the appropriate response.
> +	 *
> +	 *  - When for example "num" is two and we successfully complete
> +	 *    the first message but get an error part way through the
> +	 *    second, it's unclear whether that should be reported as
> +	 *    one (discarding status on the second message) or errno
> +	 *    (discarding status on the first one).
> +	 *
> +	 *  - In multi-master cases, there's no consistent way to report
> +	 *    lost arbitration (and properly decide to reissue messages
> +	 *    that need it).
> +	 */

I agree, but I don't really know how I would address these issues. I am
also not sure if they are worth addressing in practice.

> +
>  	if (adap->algo->master_xfer) {
>  #ifdef DEBUG
>  		for (ret = 0; ret < num; ret++) {
> @@ -1132,6 +1165,14 @@ int i2c_transfer(struct i2c_adapter * ad
>  }
>  EXPORT_SYMBOL(i2c_transfer);
>  
> +/**
> + * i2c_master_send - issue a single I2C message in master transmit mode
> + * @client: Handle to slave device
> + * @buf: Data that will be written to the slave
> + * @count: How many bytes to write
> + *
> + * Returns negative errno, or else the number of bytes written.
> + */
>  int i2c_master_send(struct i2c_client *client,const char *buf ,int count)
>  {
>  	int ret;
> @@ -1151,6 +1192,14 @@ int i2c_master_send(struct i2c_client *c
>  }
>  EXPORT_SYMBOL(i2c_master_send);
>  
> +/**
> + * i2c_master_recv - issue a single I2C message in master receive mode
> + * @client: Handle to slave device
> + * @buf: Where to store data read from slave
> + * @count: How many bytes to read
> + *
> + * Returns negative errno, or else the number of bytes read.
> + */
>  int i2c_master_recv(struct i2c_client *client, char *buf ,int count)
>  {
>  	struct i2c_adapter *adap=client->adapter;
> @@ -1456,6 +1505,21 @@ static int i2c_smbus_check_pec(u8 cpec, 
>  	return 0;
>  }
>  
> +/**
> + * i2c_smbus_write_quick - SMBus "quick command" protocol
> + * @client: Handle to slave device
> + * @value: I2C_SMBUS_READ or I2C_SMBUS_WRITE

>From the users' perspective, the value is really 0 or 1. For SMBus, the
"quick command" is always a "write transaction". It just happens that
the single bit of data is carried in what is the direction bit for all
other transactions, but that's an implementation detail the user
doesn't need to know about.

(I think the world would be better if Intel had never included this
"quick command" in their SMBus specification. It's clearly incompatible
with I2C and I never saw a device using it anyway.)

It's probably not worth arguing on this anyway: I've just removed the
last in-kernel user of this function, so we are going to drop it. It
was only ever used for 24RF08 corruption prevention, and now that
i2c-core handles it, device drivers no longer need to care. I've never
seen a device requiring the SMBus quick command, and i2c-core calls
i2c_smbus_xfer() directly, so i2c_smbus_write_quick() can go away.

If it is ever really needed, we will just add it back then.

> + *
> + * This executes the SMBus "quick command" protocol, returning negative errno
> + * else zero on success.
> + *
> + * SMBus devices are required to ACK these messages, so they are often used
> + * for device discovery.  Pure I2C devices may choose not to ACK them if they
> + * are busy.  Messages to PMBus devices must start with I2C_SMBUS_WRITE, so
> + * a "quick" message of I2C_SMBUS_READ to an PMBus device will be get a NAK
> + * response and may also trigger a protocol error notification (SMBALERT# or
> + * host notify).
> + */
>  s32 i2c_smbus_write_quick(struct i2c_client *client, u8 value)
>  {
>  	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> @@ -1463,6 +1527,13 @@ s32 i2c_smbus_write_quick(struct i2c_cli
>  }
>  EXPORT_SYMBOL(i2c_smbus_write_quick);
>  
> +/**
> + * i2c_smbus_read_byte - SMBus "receive byte" protocol
> + * @client: Handle to slave device
> + *
> + * This executes the SMBus "receive byte" protocol, returning negative errno
> + * else the byte received from the device.
> + */
>  s32 i2c_smbus_read_byte(struct i2c_client *client)
>  {
>  	union i2c_smbus_data data;
> @@ -1475,6 +1546,14 @@ s32 i2c_smbus_read_byte(struct i2c_clien
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_byte);
>  
> +/**
> + * i2c_smbus_write_byte - SMBus "send byte" protocol
> + * @client: Handle to slave device
> + * @value: Byte to be sent
> + *
> + * This executes the SMBus "send byte" protocol, returning negative errno
> + * else zero on success.
> + */
>  s32 i2c_smbus_write_byte(struct i2c_client *client, u8 value)
>  {
>  	return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
> @@ -1482,6 +1561,14 @@ s32 i2c_smbus_write_byte(struct i2c_clie
>  }
>  EXPORT_SYMBOL(i2c_smbus_write_byte);
>  
> +/**
> + * i2c_smbus_read_byte_data - SMBus "read byte" protocol
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + *
> + * This executes the SMBus "read byte" protocol, returning negative errno
> + * else a data byte received from the device.
> + */
>  s32 i2c_smbus_read_byte_data(struct i2c_client *client, u8 command)
>  {
>  	union i2c_smbus_data data;
> @@ -1494,6 +1581,15 @@ s32 i2c_smbus_read_byte_data(struct i2c_
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_byte_data);
>  
> +/**
> + * i2c_smbus_write_byte_data - SMBus "write byte" protocol
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @value: Byte being written
> + *
> + * This executes the SMBus "write byte" protocol, returning negative errno
> + * else zero on success.
> + */
>  s32 i2c_smbus_write_byte_data(struct i2c_client *client, u8 command, u8 value)
>  {
>  	union i2c_smbus_data data;
> @@ -1504,6 +1600,14 @@ s32 i2c_smbus_write_byte_data(struct i2c
>  }
>  EXPORT_SYMBOL(i2c_smbus_write_byte_data);
>  
> +/**
> + * i2c_smbus_read_word_data - SMBus "read word" protocol
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + *
> + * This executes the SMBus "read word" protocol, returning negative errno
> + * else a sixteen bit unsigned "word" received from the device.

I'd rather spell it "16-bit", that's what developers are used to I
think.

> + */
>  s32 i2c_smbus_read_word_data(struct i2c_client *client, u8 command)
>  {
>  	union i2c_smbus_data data;
> @@ -1516,6 +1620,15 @@ s32 i2c_smbus_read_word_data(struct i2c_
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_word_data);
>  
> +/**
> + * i2c_smbus_write_word_data - SMBus "write word" protocol
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @value: Sixteen bit "word" being written

Same here.

> + *
> + * This executes the SMBus "write word" protocol, returning negative errno
> + * else zero on success.
> + */
>  s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command, u16 value)
>  {
>  	union i2c_smbus_data data;
> @@ -1527,15 +1640,14 @@ s32 i2c_smbus_write_word_data(struct i2c
>  EXPORT_SYMBOL(i2c_smbus_write_word_data);
>  
>  /**
> - * i2c_smbus_read_block_data - SMBus block read request
> + * i2c_smbus_read_block_data - SMBus "block read" protocol
>   * @client: Handle to slave device
> - * @command: Command byte issued to let the slave know what data should
> - *	be returned
> + * @command: Byte interpreted by slave
>   * @values: Byte array into which data will be read; big enough to hold
>   *	the data returned by the slave.  SMBus allows at most 32 bytes.
>   *
> - * Returns the number of bytes read in the slave's response, else a
> - * negative number to indicate some kind of error.
> + * This executes the SMBus "block read" protocol, returning negative errno
> + * else the number of data bytes in the slave's response.
>   *
>   * Note that using this function requires that the client's adapter support
>   * the I2C_FUNC_SMBUS_READ_BLOCK_DATA functionality.  Not all adapter drivers
> @@ -1559,6 +1671,16 @@ s32 i2c_smbus_read_block_data(struct i2c
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_block_data);
>  
> +/**
> + * i2c_smbus_write_block_data - SMBus "block write" protocol
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @length: Size of data block; SMBus allows at most 32 bytes
> + * @values: Byte array which will be written.
> + *
> + * This executes the SMBus "block write" protocol, returning negative errno
> + * else zero on success.
> + */
>  s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
>  			       u8 length, const u8 *values)
>  {
> @@ -1776,10 +1898,22 @@ static s32 i2c_smbus_xfer_emulated(struc
>  	return 0;
>  }
>  
> -
> -s32 i2c_smbus_xfer(struct i2c_adapter * adapter, u16 addr, unsigned short flags,
> -                   char read_write, u8 command, int size,
> -                   union i2c_smbus_data * data)
> +/**
> + * i2c_smbus_xfer - execute SMBus protocol operations
> + * @adapter: Identifies an I2C bus

Here again, "Handle to i2c bus"?

> + * @addr: Address of SMBus slave on that bus
> + * @flags: I2C_CLIENT_* flags (usually zero or I2C_CLIENT_PEC)
> + * @read_write: I2C_SMBUS_READ or I2C_SMBUS_WRITE
> + * @command: Byte interpreted by slave, for protocols which use such bytes
> + * @protocol: SMBus protocol operation to execute, such as I2C_PROC_CALL

I2C_PROC_CALL doesn't exist, I guess you mean I2C_SMBUS_PROC_CALL.

> + * @data: Data to be read or written
> + *
> + * This executes an SMBus protocol operation, and returns a negative
> + * errno code else zero on success.
> + */
> +s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr, unsigned short flags,
> +		char read_write, u8 command, int protocol,
> +		union i2c_smbus_data *data)

Please keep the alignment on the opening parenthesis, as is done
throughout i2c-core.c.

>  {
>  	s32 res;
>  
> @@ -1788,11 +1922,11 @@ s32 i2c_smbus_xfer(struct i2c_adapter * 
>  	if (adapter->algo->smbus_xfer) {
>  		mutex_lock(&adapter->bus_lock);
>  		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
> -		                                command,size,data);
> +				command, protocol, data);

Same here...

>  		mutex_unlock(&adapter->bus_lock);
>  	} else
>  		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
> -	                                      command,size,data);
> +				command, protocol, data);

... and here.

>  
>  	return res;
>  }

Please send an updated patch, or if you prefer I can adjust it myself.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
