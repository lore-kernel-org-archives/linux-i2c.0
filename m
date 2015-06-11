From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Thu, 11 Jun 2015 12:38:08 +0300
Message-ID: <20150611093808.GS1478@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150609085146.GD1478@lahna.fi.intel.com>
 <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com>
 <20150610070722.GM1478@lahna.fi.intel.com>
 <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 10, 2015 at 05:05:16PM +0200, christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org wrote:
>    We should understand why the controller was disabled after successful
>    transfers in the first place, however. Maybe some quirk with older
>    versions of the hardware? Mika, do you have any memories about this?

I think it was in the original driver even before I did Intel specific
changes to that. I have no idea why it is done. Probably, like you said,
because some older version of the hardware needed it.
