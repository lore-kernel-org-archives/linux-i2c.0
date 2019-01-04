From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
Date: Thu, 3 Jan 2019 21:49:27 -0500
Message-ID: <20190103214927.2bf947ca@vmware.local.home>
References: <20190104004203.116155-1-jsperbeck@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104004203.116155-1-jsperbeck@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Sperbeck <jsperbeck@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  3 Jan 2019 16:42:03 -0800
John Sperbeck <jsperbeck@google.com> wrote:

> If an smbus transfer fails, there's no guarantee that the output
> buffer was written.  So, avoid copying from the output buffer when
> tracing after an error.  This was 'mostly harmless', but would trip
> up kasan checking if left-over cruft in byte 0 is a large length,
> causing us to read from unwritten memory.
> 
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  drivers/i2c/i2c-core-smbus.c |  2 +-
>  include/trace/events/smbus.h | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 9cd66cabb84f..132119112596 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  trace:
>  	/* If enabled, the reply tracepoint is conditional on read_write. */
>  	trace_smbus_reply(adapter, addr, flags, read_write,
> -			  command, protocol, data);
> +			  command, protocol, data, res);
>  	trace_smbus_result(adapter, addr, flags, read_write,
>  			   command, protocol, res);
>  
> diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> index d2fb6e1d3e10..b6376a7c7e74 100644
> --- a/include/trace/events/smbus.h
> +++ b/include/trace/events/smbus.h
> @@ -138,8 +138,8 @@ TRACE_EVENT_CONDITION(smbus_reply,
>  	TP_PROTO(const struct i2c_adapter *adap,
>  		 u16 addr, unsigned short flags,
>  		 char read_write, u8 command, int protocol,
> -		 const union i2c_smbus_data *data),
> -	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
> +		 const union i2c_smbus_data *data, int res),
> +	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
>  	TP_CONDITION(read_write == I2C_SMBUS_READ),

Hmm, instead of tracing nothing, as this is already a "conditional
trace event", why not add to that condition:

	TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),

Unless you want to still trace some data on failure.

-- Steve

>  	TP_STRUCT__entry(
>  		__field(int,	adapter_nr		)
> @@ -159,16 +159,16 @@ TRACE_EVENT_CONDITION(smbus_reply,
>  		switch (protocol) {
>  		case I2C_SMBUS_BYTE:
>  		case I2C_SMBUS_BYTE_DATA:
> -			__entry->len = 1;
> +			__entry->len = res < 0 ? 0 : 1;
>  			goto copy;
>  		case I2C_SMBUS_WORD_DATA:
>  		case I2C_SMBUS_PROC_CALL:
> -			__entry->len = 2;
> +			__entry->len = res < 0 ? 0 : 2;
>  			goto copy;
>  		case I2C_SMBUS_BLOCK_DATA:
>  		case I2C_SMBUS_BLOCK_PROC_CALL:
>  		case I2C_SMBUS_I2C_BLOCK_DATA:
> -			__entry->len = data->block[0] + 1;
> +			__entry->len = res < 0 ? 0 : data->block[0] + 1;
>  		copy:
>  			memcpy(__entry->buf, data->block, __entry->len);
>  			break;
