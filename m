From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 0/6] i2cset changes
Date: Tue, 15 Feb 2011 10:45:55 +0100
Message-ID: <20110215104555.6e0f7c32@endymion.delvare>
References: <1297706773-26389-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297706773-26389-1-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Feb 2011 10:06:07 -0800, Guenter Roeck wrote:
> The following series of patches removes the obsolete means to specify the value mask,
> improves parameter error detection for the i2cset command, and cleans up the code a bit.
> 
> Note: Patch revision in headline was updated only if the individual patch is either new
> or was changed.
> 
> v2:
> - Split single patch into multiple individual patches
> - Included code review feedback
> 
> v3:
> - For block commands, check for number of arguments only after checking if pec
>   is supported.
> - Report "Too many arguments" instead of "Bad number of arguments".
> - Committed blank replacement patch separately
> - Check valid range for data value mask (patch #6)

This version looks pretty good, please commit. Thanks!

-- 
Jean Delvare
