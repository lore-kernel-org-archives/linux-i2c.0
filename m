From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 34/34] usb: typec: tcpm: fusb302: simplify getting the
 adapter of a client
Date: Thu, 13 Jun 2019 11:54:52 +0200
Message-ID: <20190613095452.qim3khiqcz2iwkbr@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-35-wsa+renesas@sang-engineering.com>
 <bb8439e5-f56a-c848-180f-1feddbb198fe@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb8439e5-f56a-c848-180f-1feddbb198fe@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 05:59:17AM -0700, Guenter Roeck wrote:
> On 6/8/19 3:56 AM, Wolfram Sang wrote:
> > We have a dedicated pointer for that, so use it. Much easier to read and
> > less computation involved.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> > ---
> > 
> > Please apply to your subsystem tree.
> > 
> >   drivers/usb/typec/tcpm/fusb302.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > index 7302f7501ec9..c524088246ee 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -1697,13 +1697,12 @@ static int fusb302_probe(struct i2c_client *client,
> >   			 const struct i2c_device_id *id)
> >   {
> >   	struct fusb302_chip *chip;
> > -	struct i2c_adapter *adapter;
> > +	struct i2c_adapter *adapter = client->adapter;
> >   	struct device *dev = &client->dev;
> >   	const char *name;
> >   	int ret = 0;
> >   	u32 v;
> > -	adapter = to_i2c_adapter(client->dev.parent);
> >   	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> >   		dev_err(&client->dev,
> >   			"I2C/SMBus block functionality not supported!\n");
> > 
> 
