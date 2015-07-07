From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2] i2c-tools: Implement Module.mk for eeprog subdir
Date: Tue, 7 Jul 2015 18:58:17 +0200
Message-ID: <20150707185817.5cec7008@endymion.delvare>
References: <1435601687-6177-1-git-send-email-matwey.kornilov@gmail.com>
	<20150707172233.54abcc72@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150707172233.54abcc72-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matwey V. Kornilov" <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Jul 2015 17:22:33 +0200, Jean Delvare wrote:
> Hi Matwey,
> 
> On Mon, 29 Jun 2015 21:14:47 +0300, Matwey V. Kornilov wrote:
> > Move eeprog to separate subdir and implement Module.mk for it
> > 
> > Signed-off-by: Matwey V. Kornilov <matwey.kornilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  eeprog/24cXX.c         | 185 ++++++++++++++++++++++++++++++++
> >  eeprog/24cXX.h         |  58 ++++++++++
> >  eeprog/Module.mk       |  67 ++++++++++++
> >  eeprog/README.eeprog   |  12 +++
> >  eeprog/eeprog.8        | 103 ++++++++++++++++++
> >  eeprog/eeprog.c        | 283 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  eepromer/24cXX.c       | 185 --------------------------------
> >  eepromer/24cXX.h       |  58 ----------
> >  eepromer/Makefile      |   6 +-
> >  eepromer/README.eeprog |  12 ---
> >  eepromer/eeprog.8      | 103 ------------------
> >  eepromer/eeprog.c      | 283 -------------------------------------------------
> >  12 files changed, 710 insertions(+), 645 deletions(-)
> >  create mode 100644 eeprog/24cXX.c
> >  create mode 100644 eeprog/24cXX.h
> >  create mode 100644 eeprog/Module.mk
> >  create mode 100644 eeprog/README.eeprog
> >  create mode 100644 eeprog/eeprog.8
> >  create mode 100644 eeprog/eeprog.c
> >  delete mode 100644 eepromer/24cXX.c
> >  delete mode 100644 eepromer/24cXX.h
> >  delete mode 100644 eepromer/README.eeprog
> >  delete mode 100644 eepromer/eeprog.8
> >  delete mode 100644 eepromer/eeprog.c
> 
> The patch does not apply to SVN, not sure how you generated it.
> 
> No big deal, I get the idea, I'll redo it myself. Some SVN magic is
> needed to handle file moves properly anyway.

All committed with some adjustments:

http://lm-sensors.org/changeset/6305
http://lm-sensors.org/changeset/6306
http://lm-sensors.org/changeset/6307
http://lm-sensors.org/changeset/6308

Does that work for you?

-- 
Jean Delvare
SUSE L3 Support
