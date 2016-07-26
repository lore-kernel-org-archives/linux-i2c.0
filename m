From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] i2c: i2c-cros-ec-tunnel: Reduce logging noise
Date: Tue, 26 Jul 2016 13:13:21 -0700
Message-ID: <20160726201321.GA11345@roeck-us.net>
References: <1469480337-8753-1-git-send-email-linux@roeck-us.net>
 <CAD=FV=XEFuDKyA2sZCOze=KvatuH3qH8E69qkVW7RsVUzUNgDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43533 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbcGZUNY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jul 2016 16:13:24 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=XEFuDKyA2sZCOze=KvatuH3qH8E69qkVW7RsVUzUNgDw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jul 26, 2016 at 11:20:31AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 25, 2016 at 1:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > If an i2c access through i2c-cros-ec-tunnel returns an error, the following
> > log message is seen on the console.
> >
> > cros-ec-i2c-tunnel ff200000.spi:ec@0:i2c-tunnel:
> >                         Error parsing EC i2c message -121
> >
> > This can happen a lot if, for example, the i2c-detect command is executed.
> >
> > Since it is perfectly normal for an i2c controller to report an error,
> > drop the message. Also, report -ENXIO instead of -EREMOTEIO if the access
> > error is due to NAK from the device, and return -EIO instead of -EREMOTEIO
> > for unknown errors, as suggested in Documentation/i2c/fault-codes.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Drop message entirely instead of replacing it with dev_dbg,
> >     and return -EIO instead of -EREMOTEIO for unknown errors.
> >
> >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> > index a0d95ff682ae..7b9b2ff97d77 100644
> > --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> > +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> > @@ -154,8 +154,10 @@ static int ec_i2c_parse_response(const u8 *buf, struct i2c_msg i2c_msgs[],
> >         resp = (const struct ec_response_i2c_passthru *)buf;
> >         if (resp->i2c_status & EC_I2C_STATUS_TIMEOUT)
> >                 return -ETIMEDOUT;
> > -       else if (resp->i2c_status & EC_I2C_STATUS_ERROR)
> > -               return -EREMOTEIO;
> > +       else if (resp->i2c_status & EC_I2C_STATUS_NAK)
> > +               return -ENXIO;
> > +       else if (resp->i2c_status)
> 
> IMHO this should continue to be checking (resp->i2c_status &
> EC_I2C_STATUS_ERROR).  There is no guarantee that all future status
> bits will be errors but that #define should continue to be updated to
> be all bits that are errors:
> 
> /* Any error */
> #define EC_I2C_STATUS_ERROR (EC_I2C_STATUS_NAK | EC_I2C_STATUS_TIMEOUT)
> 
Ok, makes sense. I'll resubmit.

Guenter

> 
> > +               return -EIO;
> >
> >         /* Other side could send us back fewer messages, but not more */
> >         if (resp->num_msgs > *num)
> > @@ -222,10 +224,8 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
> >         }
> >
> >         result = ec_i2c_parse_response(msg->data, i2c_msgs, &num);
> > -       if (result < 0) {
> > -               dev_err(dev, "Error parsing EC i2c message %d\n", result);
> > +       if (result < 0)
> 
> Personally I wouldn't expect an i2c timeout and I would love i2c
> timeouts to continue to be noisy.  ...but if others don't feel the
> same way then I don't feel strongly.
> 
> Obviously NAKs shouldn't be noisy.  I'm terribly surprised that they
> were before.  I know I've run i2cdetect before and not seen the noise.
> Ah, I see.  Looks like this noisiness was introduced in commit
> a841178445bb ("mfd: cros_ec: Use a zero-length array for command
> data")
> 
> 
> 
> -Doug
