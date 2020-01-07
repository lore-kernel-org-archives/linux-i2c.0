From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 04/12] i2c: ocores: convert to use i2c_new_client_device()
Date: Tue, 07 Jan 2020 20:58:03 +0100
Message-ID: <87imlnjayc.fsf@dell.be.48ers.dk>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
        <20200107174748.9616-5-wsa+renesas@sang-engineering.com>
        <87muazjewd.fsf@dell.be.48ers.dk> <20200107193125.GA10117@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107193125.GA10117@ninjato> (Wolfram Sang's message of "Tue,
        7 Jan 2020 20:31:25 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 > Hi Peter,
 > a happy new year to you!

thanks, You too!

 >> > Move away from the deprecated API and return the shiny new ERRPTR where
 >> > useful.
 >> 
 >> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
 >> 
 >> I didn't follow the discussion, but I don't see any returns anywhere?

 > Yeah, an ERRPTR is not "useful" here. However, the old API is going to
 > be removed, so your driver is converted, too.

Ok, great.

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
