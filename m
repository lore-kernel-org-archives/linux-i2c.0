From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] i2c: use void pointers for supplying data for reads
 and writes
Date: Tue, 12 Nov 2019 11:11:49 -0800
Message-ID: <20191112191149.GA13374@dtor-ws>
References: <20191112005826.GA96746@dtor-ws>
 <f1bda5eb-b3ad-e7e1-f832-54a62e708d9c@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f1bda5eb-b3ad-e7e1-f832-54a62e708d9c@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 12, 2019 at 09:45:56AM +0100, Luca Ceresoli wrote:
> Hi Dmitry,
> 
> On 12/11/19 01:58, Dmitry Torokhov wrote:
> > There is no need to force users of i2c_master_send()/i2c_master_recv()
> > and other i2c read/write bulk data API to cast everything into u8
> > pointers.  While everything can be considered byte stream, the drivers
> > are usually work with more structured data.
> > 
> > Let's switch the APIs to accept [const] void pointers to cut amount of
> > casting needed.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I agree on the principle, but I have a question, see below.
> 
> [...]
> >  s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> > -					      u8 command, u8 length, u8 *values)
> > +					      u8 command, u8 length, void *values)
> >  {
> >  	u8 i = 0;
> >  	int status;
> > @@ -647,8 +648,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> >  			status = i2c_smbus_read_word_data(client, command + i);
> >  			if (status < 0)
> >  				return status;
> > -			values[i] = status & 0xff;
> > -			values[i + 1] = status >> 8;
> > +			put_unaligned_le16(status, values + i);
> 
> The switch to put_unaligned_le16() looks unrelated, is it?

Yeah, I'll split it out.

> 
> >  			i += 2;
> >  		}
> >  	}
> > @@ -657,7 +657,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> >  		status = i2c_smbus_read_byte_data(client, command + i);
> >  		if (status < 0)
> >  			return status;
> > -		values[i] = status;
> > +		*(u8 *)(values + i) = status;
> 
> My preference is to use an u8* helper variable in these cases:

Sure, I can do this.

> 
> s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client
> *client,
> -			      u8 command, u8 length, u8 *values)
> +			      u8 command, u8 length, void *buf)
>  {
> +	u8 *bytes = buf;
> @@
> -		values[i] = status;
> +		bytes[i] = status;
> 
> This clarifies we are accessing the raw bytes, avoids typecasts in the
> middle of code for readability and avoids void pointer math.
> 
> PS: look, it's exactly what you do in the max1363.c file below! :)
> 
> > diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> > index 5c2cc61b666e7..48ed76a0e83d4 100644
> > --- a/drivers/iio/adc/max1363.c
> > +++ b/drivers/iio/adc/max1363.c
> > @@ -182,9 +182,9 @@ struct max1363_state {
> >  	struct regulator		*vref;
> >  	u32				vref_uv;
> >  	int				(*send)(const struct i2c_client *client,
> > -						const char *buf, int count);
> > +						const void *buf, int count);
> >  	int				(*recv)(const struct i2c_client *client,
> > -						char *buf, int count);
> > +						void *buf, int count);
> >  };
> >  
> >  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> > @@ -310,27 +310,29 @@ static const struct max1363_mode
> >  	return NULL;
> >  }
> >  
> > -static int max1363_smbus_send(const struct i2c_client *client, const char *buf,
> > +static int max1363_smbus_send(const struct i2c_client *client, const void *buf,
> >  		int count)
> >  {
> > +	const u8 *data = buf;
> 
> Here it is! ^
>

Thanks for the review!

-- 
Dmitry
