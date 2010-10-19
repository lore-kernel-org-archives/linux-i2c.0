From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c/mux: Driver for PCA9541 I2C Master Selector
Date: Tue, 19 Oct 2010 20:31:01 +0200
Message-ID: <20101019203101.197d493d@endymion.delvare>
References: <1286932516-20689-1-git-send-email-guenter.roeck@ericsson.com>
	<20101019190647.314302e7@endymion.delvare>
	<20101019180805.GA31594@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101019180805.GA31594-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Oct 2010 11:08:05 -0700, Guenter Roeck wrote:
> On Tue, Oct 19, 2010 at 01:06:47PM -0400, Jean Delvare wrote:
> > On Tue, 12 Oct 2010 18:15:16 -0700, Guenter Roeck wrote:
> > > +     if (data->virt_adap == NULL) {
> > > +             dev_err(&client->dev,
> > > +                     "failed to register master selector as bus %d\n",
> > > +                     force);
> > 
> > This error message is somewhat confusing if "force" is 0: in that case
> > you didn't request any specific bus number.
>
> This is from pca954x code. Not sure how to rephrase it. Got an idea ?

Just "failed to register master selector\n" should do. The adapter
number doesn't really add any value.

-- 
Jean Delvare
