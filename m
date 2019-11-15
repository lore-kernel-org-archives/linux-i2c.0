From: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] i2c: of: Populate fwnode in of_i2c_get_board_info()
Date: Fri, 15 Nov 2019 14:15:25 -0800
Message-ID: <CAGETcx9isTDaRW0KgdWVHxxTKdERB4DPeQyCa9QWXniNTpuZ_A@mail.gmail.com>
References: <20191115045049.261104-1-saravanak@google.com> <20191115053201.GA800105@kroah.com>
 <20191115091035.GA2227@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191115091035.GA2227@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Android Kernel Team <kernel-team@android.com>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 15, 2019 at 1:10 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Nov 15, 2019 at 01:32:01PM +0800, Greg Kroah-Hartman wrote:
> > On Thu, Nov 14, 2019 at 08:50:48PM -0800, Saravana Kannan wrote:
> > > This allows the of_devlink feature to work across i2c devices too. This
> > > avoid unnecessary probe deferrals of i2c devices, defers consumers of
> > > i2c devices till the i2c devices probe, and allows i2c drivers to
> > > implement sync_state() callbacks.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > > The of_devlink feature is present in driver-core-next branch. It started
> > > off with [1] but it has been improving since then.
> > >
> > > [1] -- https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/
> > >
> > >  drivers/i2c/i2c-core-of.c | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Wolfram, I can take this through my tree now if you have no objections
> > to this.
>
> What would be the advantage?

Of the patch or of him picking it up?

Advantage of the patch is in the commit text. Details of of_devlink
are also provided in the link I gave earlier.

Advantage of Greg picking it up: This patch will get tested/seen with
the set of changes (of_devlink) with which it'll have the biggest
functional impact.

-Saravana
