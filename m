From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Status of multiplexed i2c support
Date: Tue, 10 Aug 2010 14:29:38 +0200
Message-ID: <20100810142938.5a2e1bd1@hyperion.delvare>
References: <20100721042922.GA30524@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100721042922.GA30524-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

Sorry for the late answer, I am just returning from vacation.

On Tue, 20 Jul 2010 21:29:22 -0700, Guenter Roeck wrote:
> what is the current status of i2c mux support, specifically support for pca945x ?

(Assuming this is a typo and you really meant pca954x.)

Support is ready for public consumption and will be merged upstream
very soon now (i.e. before 2.6.36-rc1.) The PCA954x family will be the
first supported one, support will be merged together with core
multiplexing support.

Note that I don't take much credit for this, all the hard work was done
by Rodolfo Giometti and Michael Lawnick (Cc'd), which were additionally
kind enough to patiently wait for someone (that is me) to review their
work.

-- 
Jean Delvare
