From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Date: Sat, 08 Aug 2015 15:51:54 +0300
Message-ID: <55C5FB6A.5010300@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com> <20150807161055.GD25357@katana> <55C4D9B2.3000708@mleia.com> <20150807223456.GA1527@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150807223456.GA1527@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Ian Munsie <imunsie-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 08.08.2015 01:34, Wolfram Sang wrote:
> 
>> if we're talking about this particular series, you should have them in
>> your mailbox, since you have them applied in wsa/i2c/for-next:
> 
> Those are already in linus tree. I mean all drivers which use struct
> i2c_driver. Or do you prefer they go via Greg? I am fine with both.
> 

I think you may find most of the changes applied by Greg into
misc/char-misc-next branch.

The only change from the series, which is not found in
misc/char-misc-next or i2c/for-next is related to at25 driver (IC is
sitting on SPI):

  https://lkml.org/lkml/2015/7/26/101

Change 8/8 for sunxi is outdated due to accepted NVMEM framework.

With best wishes,
Vladimir
