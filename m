From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
Date: Thu, 01 Oct 2015 20:51:59 +0200
Message-ID: <560D80CF.6050500@schinagl.nl>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com> <560813CF.4000807@schinagl.nl> <20150929120943.GP7104@lukather>
Reply-To: oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBUEBW2YAKGQE4NTAMOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150929120943.GP7104@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey Maxime,

On 29-09-15 14:09, Maxime Ripard wrote:
> On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
>> Hey Hans,
>>
>> On 27-09-15 16:57, Hans de Goede wrote:
>>> According to the datasheets to n factor for dividing the tclk is
>>> 2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
>>> on other mv64xxx implementations.
>> Ah!
>>> I've contacted Allwinner about this and they have confirmed that the
>>> datasheet is correct.
>>>
>>> This commit fixes the clk-divider calculations for Allwinner SoCs
>>> accordingly.
>> So this explains why all my i2c frequenties are double of what I setup.
>> Thanks for taking the time of figuring it out! I'll give it a test hopefully
>> soon.
> It would have been great to let us know...
If your talking about past tence, I actually did ;) [0][1] and I 
actually had a tree made ready just 3 weeks ago with 3.15 to start my 
bisection with. It seemed logical to see if it worked there as that was 
the first iteration (based on the sunxi/allwinner based tree before the 
mv migration.

Anyway, I even built tried to build the kernel! but my gcc failed to 
build it so i put it on the back-burner for a while.

WIth Hans having figured it out and fixing it, I'll absolutly will take 
a nother look and check with a scope if it all works out now.

Olliver

[0] http://irclog.whitequark.org/linux-sunxi/2015-01-16#11522114;
[1] http://s24.postimg.org/yiykh6kkl/DS1_Z_Quick_Print2.png


> Maxime
>
