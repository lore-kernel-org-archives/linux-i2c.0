From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [Patch v2] power/mpc85xx: Add delay after enabling I2C master
Date: Mon, 23 Sep 2013 15:16:58 -0700
Message-ID: <5240BDDA.3050206@freescale.com>
References: <1379369185-14590-1-git-send-email-yorksun@freescale.com> <20130923071012.GD3051@katana> <5240B626.9050904@freescale.com> <20130923220921.GA3244@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923220921.GA3244@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/23/2013 03:09 PM, Wolfram Sang wrote:
> 
>>> Please, no unnecessary #ifdefs in code. We have 'struct mpc_i2c_data'
>>> already.
>>>
>>
>> I am not pround of this change. Please elaborate how to use mpc_i2c_data
>> to separate the mpc85xx from the rest.
> 
> Search for 'match->data' and see how the custom setup function and
> custom prescaler value is used.
> 
I see. It is using device tree to match. But the device tree doesn't
have enough information. Many platforms don't specifiy if compatible
with mpc85xx, so they fall into .compatible = "fsl-i2c". Please advise.

York
