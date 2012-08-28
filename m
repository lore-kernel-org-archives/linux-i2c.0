From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: add Renesas R-Car I2C driver
Date: Tue, 28 Aug 2012 10:12:59 +0200
Message-ID: <20120828101259.409b410b@endymion.delvare>
References: <871uk04aa2.wl%kuninori.morimoto.gx@renesas.com>
	<CAM=Q2ctETiVdyKBd_MxY2Ts=1XMPa_cdEJRkQpEySL6du9oLmw@mail.gmail.com>
	<878vczd1hw.wl%kuninori.morimoto.gx@renesas.com>
	<CAM=Q2cs5pFpVjqa_MFCLTFqdCo6SSm-1Ep=WtJ7fpABzWEGD9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cs5pFpVjqa_MFCLTFqdCo6SSm-1Ep=WtJ7fpABzWEGD9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 Aug 2012 11:09:10 +0530, Shubhrajyoti Datta wrote:
> On Tue, Aug 28, 2012 at 11:03 AM, Kuninori Morimoto
> <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > Hi Shubhrajyoti
> >
> > Thank you for checking patch.
> > I create v2 patch and post it soon.
> > There is not big reason, but I would like to keep adap->retries for now.
> >
> Or maybe just wait for Jean's advice on the same.

Using adap->retries is fine, it only covers automatic retries in
specific cases (arbitration loss). The other cases are indeed left for
the slave driver to handle.

-- 
Jean Delvare
