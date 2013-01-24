From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-core: Remove definition of i2c_smbus_process_call
Date: Thu, 24 Jan 2013 08:26:35 +0100
Message-ID: <20130124072635.GE8364@nekote.pengutronix.de>
References: <1353322902-3059-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1353322902-3059-1-git-send-email-tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 19, 2012 at 04:31:42PM +0530, Tushar Behera wrote:
> i2c_smbus_process_call has no users in the kernel, so this can be
> removed. Documentation for the same has been updated accordingly.
> 
> Fixes following sparse warning.
> drivers/i2c/i2c-core.c:1871:5: warning: symbol 'i2c_smbus_process_call'
> was not declared. Should it be static?
> 
> Signed-off-by: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yes, no users, no entry in i2c.h -> can go.

Applied to next, thanks!
