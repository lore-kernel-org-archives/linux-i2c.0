From: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/1] PN544 NFC driver.
Date: Thu,  4 Nov 2010 14:57:52 +0200
Message-ID: <1288875473-22252-1-git-send-email-matti.j.aaltonen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi.

On Mon, 2010-11-01 at 11:00 -0700, ext Randy Dunlap wrote:
> Use %zd to print ssize_t variables and %zu to print size_t:
> 
> drivers/nfc/pn544.c:332: warning: format '%d' expects type 'int',
> but argument 6 has type 'size_t'
> drivers/nfc/pn544.c:442: warning: format '%d' expects type 'int',
> but argument 6 has type 'size_t'

Fixed.

On Fri, 2010-10-29 at 14:35 -0700, ext Andrew Morton wrote:
On Fri, 29 Oct 2010 09:26:09 +0300
> "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > +static void __exit pn544_exit(void)
> > +{
> > +	flush_scheduled_work();
> 
> You said this had been removed.  Did you send the correct version?

Now I've removed it.

I've also replaced short msleeps with usleep_range calls. And in addition
I rewrote the document file.

B.R.
Matti 






 

Matti J. Aaltonen (1):
  NFC: Driver for NXP Semiconductors PN544 NFC chip.

 Documentation/nfc/nfc-pn544.txt |  117 +++++
 drivers/Kconfig                 |    2 +
 drivers/Makefile                |    2 +-
 drivers/nfc/Kconfig             |   30 ++
 drivers/nfc/Makefile            |    5 +
 drivers/nfc/pn544.c             |  891 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfc/pn544.h       |   97 +++++
 7 files changed, 1143 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/nfc/nfc-pn544.txt
 create mode 100644 drivers/nfc/Kconfig
 create mode 100644 drivers/nfc/Makefile
 create mode 100644 drivers/nfc/pn544.c
 create mode 100644 include/linux/nfc/pn544.h
