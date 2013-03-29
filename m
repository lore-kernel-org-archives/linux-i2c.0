From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Fri, 29 Mar 2013 11:28:39 -0700
Message-ID: <CAD=FV=XyBZXD1dsOy4kY3CjkFiJXCO+taAJ-zZ8op6V-z9J8jQ@mail.gmail.com>
References: <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <CAD=FV=UW4wGFqsg2B3MmC24jhnba5PSvCh8Wck-V6iuYk+Xifw@mail.gmail.com>
 <20130329115821.GC6359@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130329115821.GC6359-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Prashanth G <prashanth.g@sam>
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Fri, Mar 29, 2013 at 4:58 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> I can't recall the reason standard I2C bus arbitration is not working
> and why this is needed. I need the feeling this is a solution and not a
> workaround. I mean driver bugs can be fixed and I am unsure if it is a
> good idea to open the i2c-arbitration-*.c namespace.

Thanks for the feedback!

Separately from a discussion of the technical merits, I'd say that
this patch is needed because the Embedded Controller (EC) on the ARM
Chromebook shipped expecting to communicate with this scheme.  While
it is technically possible to update the read-write copy of the
software on the EC, it would be prohibitively difficult to ship an
update that changed the communication method.  Specifically we'd still
require fallback to the old scheme in cases where we need to talk to
the read-only copy of the software on the EC.

...but we can also talk technical merits.  One person on our team
spent a bit of time thinking about this and decided that traditional
i2c arbitration can't actually be used in this case (aside from the
general experience about multimaster being buggy).  Specifically, our
bus is setup with these devices on it:

* AP (running Linux) - Master only.  Only talks when awake.
* EC (running custom code) - Acts as a master and _also_ a slave.
* Battery (smart battery) - Only a slave
* Power Management Unit (PMU - tps65090) - Only a slave

Both the AP and the EC would like to talk to the battery and PMU.  The
AP needs to be able to talk to the EC.

The problem here is that the EC is both a master and a slave.  It's my
understanding that if the AP tries to talk EC on the bus at the same
time that the EC is trying to talk to the battery of PMU that we can
get into trouble.  Specifically the EC needs to be switched to "master
mode" to talk to the battery/PMU and thus has a period of time where
it won't be listening for the AP's messages.  The arbitration lines
make it very clear that the EC has gained mastery of the bus and is
free to switch into "master mode" without worrying that the AP may
talk to it.

I will freely admit that I am not an expert on multimater I2C so if
the above is incorrect then let me know.  As I said, though, it's
still useful to get this patch in because that's simply how the
shipping EC expects to communicate.

Thanks!  :)

-Doug
