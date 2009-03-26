From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [patch] add pca9543 driver
Date: Thu, 26 Mar 2009 15:51:05 +0100
Message-ID: <20090326155105.5dfbd898@hyperion.delvare>
References: <1238078818-25977-1-git-send-email-os@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759590AbZCZOvm@vger.kernel.org>
In-Reply-To: <1238078818-25977-1-git-send-email-os@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskar Schirmer <os@emlix.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Chris Zankel <chris@zankel.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Mar 2009 15:46:58 +0100, Oskar Schirmer wrote:
> support pca9543 i2c bus switch chip
> 
> Signed-off-by: Oskar Schirmer <os@emlix.com>
> ---
>  drivers/i2c/chips/Kconfig   |    3 +
>  drivers/i2c/chips/Makefile  |    1 +

Please read the header of these two files carefully again.

>  drivers/i2c/chips/pca9543.c |  188 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/pca9543.c
> (...)

-- 
Jean Delvare
