From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 04/12] i2c: ocores: convert to use i2c_new_client_device()
Date: Tue, 07 Jan 2020 19:32:50 +0100
Message-ID: <87muazjewd.fsf@dell.be.48ers.dk>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
        <20200107174748.9616-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-5-wsa+renesas@sang-engineering.com> (Wolfram
        Sang's message of "Tue, 7 Jan 2020 18:47:38 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

 > Move away from the deprecated API and return the shiny new ERRPTR where
 > useful.

 > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I didn't follow the discussion, but I don't see any returns anywhere?

 > ---
 > Build tested only.

 >  drivers/i2c/busses/i2c-ocores.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)

 > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
 > index ca8b3ecfa93d..f5fc75b65a19 100644
 > --- a/drivers/i2c/busses/i2c-ocores.c
 > +++ b/drivers/i2c/busses/i2c-ocores.c
 > @@ -731,7 +731,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 >  	/* add in known devices to the bus */
 >  	if (pdata) {
 >  		for (i = 0; i < pdata->num_devices; i++)
 > -			i2c_new_device(&i2c->adap, pdata->devices + i);
 > +			i2c_new_client_device(&i2c->adap, pdata->devices + i);
 >  	}
 
 >  	return 0;
 > -- 
 > 2.20.1


-- 
Bye, Peter Korsgaard
