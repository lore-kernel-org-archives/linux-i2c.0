From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: designware: Rework probe() to get clock a bit
 later
Date: Fri, 19 Sep 2014 11:54:11 +0300
Message-ID: <20140919085411.GD10854@lahna.fi.intel.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <CAC5e1FqNpfnW=nAvn0LTuYm2Cwd332UCgzYkx-h1Y8WaRPdTTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC5e1FqNpfnW=nAvn0LTuYm2Cwd332UCgzYkx-h1Y8WaRPdTTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: carl peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 19, 2014 at 03:08:58PM +0800, carl peng wrote:
> On Thu, Sep 18, 2014 at 5:26 PM, Mika Westerberg
> <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > In order to be able to create missing clock for AMD (and in future possibly
> > others) we move getting clock for the device a bit later. Also make ACPI/DT
> > configuration in the same place depending on from where the device was
> > enumerated from.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Tested-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks!
