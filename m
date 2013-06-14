From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
Date: Fri, 14 Jun 2013 17:07:48 +0200
Message-ID: <51BB31C4.2090302@gmail.com>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com> <20130614140719.GC2929@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBCU6XJ6JUIOBBS7D5SGQKGQEKEGTBAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20130614140719.GC2929@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/14/13 16:07, Wolfram Sang wrote:
> On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
>> This patchset adds support for the I2C controller found on most of the
>> Allwinner SoCs, especially the already supported A10 and A13, and the
>> yet to come A31.
>>
>> This driver leverages the Marvel mv64xxx i2c controller driver, that has
>> an almost identical logic, with a slightly different register layout.
>
> \o/ Yay, that's more like it. Thanks for the rework!
>
>> It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
>
> I'd love to get some Tested-by or other tags for Marvell hardware. Any
> volunteers?

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

on Marvell Dove, v3.10-rc5 with i2c/for-next merged in.

Sebastian
