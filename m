From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [2.6 patch] the scheduled i2c driver removal
Date: Tue, 6 May 2008 21:11:45 +0200
Message-ID: <20080506211145.752f0e3f@hyperion.delvare>
References: <20080505182950.GB17139@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763929AbYEFTMY@vger.kernel.org>
In-Reply-To: <20080505182950.GB17139@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 5 May 2008 21:29:50 +0300, Adrian Bunk wrote:
> This patch contains the scheduled removal of i2c-i810, i2c-prosavage and 
> i2c-savage4.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |    7 
>  Documentation/i2c/busses/i2c-i810          |   47 ---
>  Documentation/i2c/busses/i2c-prosavage     |   23 -
>  Documentation/i2c/busses/i2c-savage4       |   26 -
>  drivers/i2c/busses/Kconfig                 |   52 ---
>  drivers/i2c/busses/Makefile                |    3 
>  drivers/i2c/busses/i2c-i810.c              |  260 ----------------
>  drivers/i2c/busses/i2c-prosavage.c         |  325 ---------------------
>  drivers/i2c/busses/i2c-savage4.c           |  185 -----------
>  9 files changed, 928 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare
