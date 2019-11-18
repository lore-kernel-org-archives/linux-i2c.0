From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] i2c: smbus: switch from loops to memcpy
Date: Mon, 18 Nov 2019 00:09:39 -0800
Message-ID: <20191118080939.GC251795@dtor-ws>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-4-dmitry.torokhov@gmail.com>
 <20191118074757.edyfvz5s3pqnu67y@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118074757.edyfvz5s3pqnu67y@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 18, 2019 at 08:47:57AM +0100, Uwe Kleine-König wrote:
> Hello Dmitry,
> 
> On Tue, Nov 12, 2019 at 12:31:32PM -0800, Dmitry Torokhov wrote:
> > When copying memory from one buffer to another, instead of open-coding
> > loops with byte-by-byte copies let's use memcpy() which might be a bit
> > faster and makes intent more clear.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - new patch using memcpy() for moving data around
> > 
> >  drivers/i2c/i2c-core-smbus.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> > index 7b4e2270eeda1..bbafdd3b1b114 100644
> > --- a/drivers/i2c/i2c-core-smbus.c
> > +++ b/drivers/i2c/i2c-core-smbus.c
> > @@ -397,8 +397,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
> >  			}
> >  
> >  			i2c_smbus_try_get_dmabuf(&msg[0], command);
> > -			for (i = 1; i < msg[0].len; i++)
> > -				msg[0].buf[i] = data->block[i - 1];
> > +			memcpy(msg[0].buf + 1, data->block, msg[0].len - 1);
> 
> Can it happen that msg[0].len is zero?

No, it can not, because of the "msg[0].len = data->block[0] + 2;" line
above.

Thanks.

-- 
Dmitry
