From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] I2C: xiic: Add OF binding support
Date: Thu, 03 May 2012 17:50:48 +0200
Message-ID: <4FA2A958.7060502@metafoo.de>
References: <1335361733-24441-1-git-send-email-lars@metafoo.de> <20120503111027.GD9574@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120503111027.GD9574-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/03/2012 01:10 PM, Wolfram Sang wrote:
> On Wed, Apr 25, 2012 at 03:48:53PM +0200, Lars-Peter Clausen wrote:
>> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> 
> Applied to next, thanks.
> 
> How are your experiences with the driver? Does it still need
> EXPERIMENTAL?

I had some issues under certain conditions, e.g. certain types of I2C transfers
would confuse the core and fail. But I hadn't had the time yet to investigate
further. So I wouldn't remove the EXPERIMENTAL yet.

- Lars
