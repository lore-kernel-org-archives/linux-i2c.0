From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 14:03:52 -0800
Message-ID: <20170104220352.GE40341@dtor-ws>
References: <20170104103233.GT5767@mail.corp.redhat.com>
 <20170104112223.GE3499@pali>
 <20170104120031.GG3499@pali>
 <20170104130252.GV5767@mail.corp.redhat.com>
 <20170104160643.GH3499@pali>
 <20170104173928.GW5767@mail.corp.redhat.com>
 <20170104174619.feke27q3ehwkylfs@ninjato>
 <20170104175456.GA40341@dtor-ws>
 <20170104215546.GA1433@katana>
 <20170104220030.GD40341@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104220030.GD40341@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 04, 2017 at 02:00:30PM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 04, 2017 at 10:55:47PM +0100, Wolfram Sang wrote:
> > 
> > > From e362a0277fd1bd6112f258664d8831d9bc6b78da Mon Sep 17 00:00:00 2001
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Date: Wed, 4 Jan 2017 09:33:43 -0800
> > > Subject: [PATCH] i2c: do not enable fall back to Host Notify by default
> > > 
> > > Falling back unconditionally to HostNotify as primary client's interrupt
> > > breaks some drivers which alter their functionality depending on whether
> > > interrupt is present or not, so let's introduce a board flag telling I2C
> > > core explicitly if we want wired interrupt or HostNotify-based one:
> > > I2C_CLIENT_HOST_NOTIFY.
> > > 
> > > For DT-based systems we introduce "host-notofy" property that we convert
> > > to I2C_CLIENT_HOST_NOTIFY board flag.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Yay, this looks better to me. One nit:
> > 
> > > +Alternatively, devices supporting SMbus Host Notify, and connected to
> > > +adapters that support this feature, may use "host-notify" property. I2C
> > > +core will create a virtual interrupt for Host Notify and assign it as
> > > +primary interrupt for the slave.
> > 
> > This paragraph sounds Linux-ish while binding docs should be OS
> > agnostic. Maybe we can shorten the second sentence to "It will be
> > assigned then as the primary interrupt for the slave."?
> 
> Heh, I just sent out patch to DT folks. Provided that they are fine with
> the new property I can either send V2 or you could edit when applying,
> whatever is easier for you.

That said, both variants are Linux-ish to me: I do not believe that
"primary slave interrupt" for I2C devices is a generic concept. Is it?
Do BSD and Windows use it?

Also, it matches the paragraph above that also talks about I2C core.

In any case, it is your decision, I'm just making random noise here.

Thanks.

-- 
Dmitry
