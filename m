From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Wed, 03 Jun 2009 10:22:38 +0200
Message-ID: <87oct53ewh.fsf@macbook.be.48ers.dk>
References: <4A2566E8.7080404@mocean-labs.com>
	<20090602224822.GE18453@fluff.org.uk>
	<20090603101533.599d41db@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090603101533.599d41db-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare's message of "Wed\, 3 Jun 2009 10\:15\:33 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Richard Rojfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

Hi,

 Jean> I don't like the idea much either, nor the implementation.

 Jean> Firstly, I don't understand why this would be needed. I can understand
 Jean> that in some cases you don't know the I2C bus number in advance, but
 Jean> then some code must still instantiate the I2C bus, and the same code
 Jean> should be able to call i2c_new_device() directly to instantiate the
 Jean> devices on that bus. Richard, did you try to just do this? If it
 Jean> doesn't work, please explain why.

Indeed. Isn't it just a matter of using i2c_add_numbered_adapter -
E.G.:

--- linux-2.6/drivers/i2c/busses/i2c-ocores.c	2008-11-26 11:16:27.000000000 +0100
+++ linux-2.6-new/drivers/i2c/busses/i2c-ocores.c	2008-12-13 19:59:12.000000000 +0100
@@ -261,11 +261,12 @@
 	/* hook up driver to tree */
 	platform_set_drvdata(pdev, i2c);
 	i2c->adap = ocores_adapter;
+	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
 
 	/* add i2c adapter to i2c tree */
-	ret = i2c_add_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add adapter\n");
 		goto add_adapter_failed;

Or am I misunderstanding the issue?

-- 
Bye, Peter Korsgaard
