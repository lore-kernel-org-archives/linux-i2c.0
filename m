From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC] drivers/clk/Kconfig: Change COMMON_CLK to tristate
Date: Wed, 17 Jun 2015 12:15:58 -0700
Message-ID: <5581C76E.1030004@freescale.com>
References: <1434567707-9352-1-git-send-email-yorksun@freescale.com> <20150617190534.GB28251@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617190534.GB28251@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 06/17/2015 12:05 PM, Wolfram Sang wrote:
> On Wed, Jun 17, 2015 at 12:01:47PM -0700, York Sun wrote:
>> COMMON_CLK has been a bool value, selected by the platforms who need
>> common clock framework. If a CCF driver is needed on an add-on device
>> such as PCIe card, COMMON_CLK can be selected individually as a
>> tristate value.
>>
>> Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> CC: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
>> CC: Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> Why do you CC the I2C list for clk patches??
> 

My apology for CC the wrong list.
It was firstly introduced in this patch http://patchwork.ozlabs.org/patch/485088/.

York
