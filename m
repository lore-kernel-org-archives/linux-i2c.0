From: Hezi Shahmoon <hezi@marvell.com>
Subject: RE: [PATCH] i2c: mv64xxx: really allow I2C offloading
Date: Tue, 20 Oct 2015 16:56:21 +0000
Message-ID: <7cbd65dd28fe445db4e3b8f0ed13ce74@IL-EXCH01.marvell.com>
References: <1445351544-26062-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020162223.GQ5379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20151020162223.GQ5379@katana>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi.

It is:
Hezi Shahmoon

Email:
hezi@marvell.com

I will fix this for future commits.

Thanks,
Hezi.

-----Original Message-----
From: Wolfram Sang [mailto:wsa@the-dreams.de] 
Sent: Tuesday, October 20, 2015 7:22 PM
To: Thomas Petazzoni
Cc: linux-i2c@vger.kernel.org; Tawfik Bayouk; Nadav Haklai; Lior Amsalem; Jason Cooper; Andrew Lunn; Sebastian Hesselbarth; Gregory Clement; Marcin Wojtas; Hezi Shahmoon; stable@vger.kernel.org
Subject: Re: [PATCH] i2c: mv64xxx: really allow I2C offloading

On Tue, Oct 20, 2015 at 04:32:24PM +0200, Thomas Petazzoni wrote:
> From: Hezi <hezi@marvell.com>

Is "Hezi" the full name?

> 
> Commit 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix 
> several problems") completely reworked the offload support, but 
> stupidly left a debugging-related "return false" at the beginning of 
> the mv64xxx_i2c_can_offload() function. This has the unfortunate 
> consequence that offloading is in fact never used, which wasn't really 
> the intention.
> 
> This commit fixes that problem by removing the stupid "return false".
> 
> Fixes: 00d8689b85a7 ("i2c: mv64xxx: rework offload support to fix 
> several problems")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hezi <hezi@marvell.com>
> [Thomas: reworked commit log and title.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Note: the original fix is from Hezi, but I rewrote the commit log, 
> which is why I authorized myself to treat my own work as being 
> "stupid". Which it really was.

:)

> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c 
> b/drivers/i2c/busses/i2c-mv64xxx.c
> index 30059c1..5801227 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -669,8 +669,6 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
>  	struct i2c_msg *msgs = drv_data->msgs;
>  	int num = drv_data->num_msgs;
>  
> -	return false;
> -
>  	if (!drv_data->offload_enabled)
>  		return false;
>  
> --
> 2.6.2
> 
