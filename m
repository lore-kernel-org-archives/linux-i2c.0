From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Mon, 9 Jan 2017 10:34:20 +0100
Message-ID: <20170109093420.GG29854@bigcity.dyn.berto.se>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
 <20161110153016.GJ26304@bigcity.dyn.berto.se>
 <20170104102550.GA1452@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104102550.GA1452@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-04 11:25:50 +0100, Wolfram Sang wrote:
> Bump...
> 
> > Yes, this is a bug in the rcar-vin driver which is addressed in the Gen3 
> > patches. However I'm not sure those patches will make it to v4.10, not 
> > much review from the V4L2 side yet (Geert and Sergei have had a few 
> > comments so there will at lest be one more iteration).
> 
> Seems your predictions were correct. I still get:
> 
> * OOPS with renesas/dt-for-v4.11 and these patches on top
> * no OOPS with renesas-drivers/master and these patches on top
> 
> So, it seems to me that we still should wait with the HDMI related
> patches of this series until the rcar-vin-gen3 branch is in -next.
> D'accord everyone?

I'm fine with waiting. But as I hinted in my previous email the review 
on the rcar-vin-gen3 branch is slow, that is nothing have happened in 
that thread since last we spoke of this...

If this is blocking or other create other issue for you please let me 
know and I will do my best to extract the fix and post it separately 
from Gen3 enablement.

-- 
Regards,
Niklas Söderlund
