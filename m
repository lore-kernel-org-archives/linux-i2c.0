From: "Chaithrika U S" <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 0/4] i2c: davinci: Add power management features
Date: Tue, 15 Dec 2009 18:27:38 +0530
Message-ID: <01fb01ca7d86$2dd0aaa0$8971ffe0$@com>
References: <1260267218-19406-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260267218-19406-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Chaithrika U S' <chaithrika-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi All,

Do you have any review comments/suggestions for this
patch series?

Regards, 
Chaithrika

On Tue, Dec 08, 2009 at 15:43:34, Chaithrika U S wrote:
> Add suspend/resume and cpufreq features to DaVinci I2C driver
> All patches apply to Linus' kernel tree.
> Testing of these features was done on DA850/OMAP-L138 EVM.
> 
> Chaithrika U S (4):
>   i2c: davinci: Remove MOD_REG_BIT and IO_ADDRESS usage
>   i2c: davinci: Add helper functions
>   i2c: davinci: Add suspend/resume support
>   i2c: davinci: Add cpufreq support
> 
>  drivers/i2c/busses/i2c-davinci.c |  224 ++++++++++++++++++++++++++++----------
>  1 files changed, 168 insertions(+), 56 deletions(-)
> 
