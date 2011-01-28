From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix error return codes
Date: Fri, 28 Jan 2011 04:15:03 +0000 (UTC)
Message-ID: <loom.20110128T051423-274@post.gmane.org>
References: <1295471693-463-1-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Guenter Roeck <guenter.roeck@...> writes:

> 
> EREMOTEIO is not a valid error return code for I2C drivers. Replace with error
> codes per Documentation/i2c/fault-codes.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@...>
> ---
ping ... any interest ?
