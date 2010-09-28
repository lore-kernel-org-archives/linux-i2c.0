From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Driver for pca9541 bus master selector
Date: Tue, 28 Sep 2010 17:16:07 +0200
Message-ID: <20100928171607.395f7736@endymion.delvare>
References: <20100928143302.GA7593@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928143302.GA7593-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Tue, 28 Sep 2010 07:33:02 -0700, Guenter Roeck wrote:
> I am in the process of writing a driver for the pca9541 bus master selector. 
> I using the i2c multiplexer framework, which fits the requirements quite nicely.
> 
> If anyone happens to know about an existing driver for this chip, please let me know.
> I would love to get some input for the arbitration mechanism needed to determine
> if and when to switch bus ownership from one master to the other.

See drivers/i2c/muxes/pca954x.c in 2.6.36-rc2 and later.

-- 
Jean Delvare
