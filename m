From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Mon, 23 Sep 2013 15:38:20 -0700
Message-ID: <5240C2DC.3010004@freescale.com>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com> <20130923071012.GD3051@katana> <5240B626.9050904@freescale.com> <20130923220921.GA3244@katana> <5240BDDA.3050206@freescale.com> <20130923223200.GB3244@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923223200.GB3244@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/23/2013 03:32 PM, Wolfram Sang wrote:
> 
>> I see. It is using device tree to match. But the device tree doesn't
>> have enough information. Many platforms don't specifiy if compatible
>> with mpc85xx, so they fall into .compatible = "fsl-i2c". 
> 
> :( Can those be fixed to use proper "fsl,mpc8544-i2c"?
> 
>> Please advise.
> 
> My PPC knowledge is a bit dusty: What about SVR/PVR to detect the 8544
> at runtime?
> 
Wolfram,

It is not only about 8544. I wrote this patch to address a timing issue
when a workaround is applied. This timing issue applies to many mpc85xx
parts, but not all of them. But it is safe to all. So checking one
SVR/PVR doesn't work.

York
