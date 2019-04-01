From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date: Mon, 1 Apr 2019 14:37:19 -0500
Message-ID: <CAErSpo6MJFJO3s4NZ61CPZngbSaOhG-s5wLJyCQbwvdcnuBP1Q@mail.gmail.com>
References: <20190325183652.252175-1-helgaas@kernel.org> <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
 <20190401140806.GB4570@kunai>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000cda31005857d26e9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401140806.GB4570@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mukesh Ojha <mojha@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

--000000000000cda31005857d26e9
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 1, 2019 at 9:08 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> > > <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> > > convert i2c-isch to platform_device") removed the use of
> > > acpi_check_region() but not the include.
> > >
> > > Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> > > intended.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Added
> >
> >     Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
> >     Reviewed-by: Jean Delvare <jdelvare@suse.de>
> >     Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> >
> > on my local branch.
> >
> > Jean, would you like me to repost this with the updates?  I assume you
> > will merge this (just based on get_maintainer.pl)?
>
> I will apply it, now that it has Jean's Rev-by. I assume this is
> for-next material despite the Fixes tag?

Definitely for-next material, not for the current release.  Jean
suggested the Fixes tag, I think since it's related to a specific
commit and could be backported together with that commit.

Should there be a MAINTAINERS update to clarify who applies patches to
drivers/i2c/busses/i2c-isch.c?  Right now, get_maintainers.pl doesn't
mention you (Wolfram).

Patch with tags attached in case it's useful to you (sorry, I'm
saddled with gmail right now and can't include it inline).

--000000000000cda31005857d26e9
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-i2c-isch-Remove-unnecessary-acpi.h-include.patch"
Content-Disposition: attachment;
	filename="0001-i2c-isch-Remove-unnecessary-acpi.h-include.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jtyr8zu10>
X-Attachment-Id: f_jtyr8zu10

RnJvbSAzNmZiZGFiODlmNWI4YWEyZDM2MTZiZDI4OWUyYzY5NWZkM2MwZjliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPgpE
YXRlOiBUdWUsIDMwIE9jdCAyMDE4IDE0OjEyOjM2IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gaTJj
OiBpc2NoOiBSZW1vdmUgdW5uZWNlc3NhcnkgYWNwaS5oIGluY2x1ZGUKCjU0ZmI0YTA1YWYwYSAo
ImkyYzogQ2hlY2sgZm9yIEFDUEkgcmVzb3VyY2UgY29uZmxpY3RzIikgaW5jbHVkZWQKPGxpbnV4
L2FjcGkuaD4gc28gd2UgY291bGQgdXNlIGFjcGlfY2hlY2tfcmVnaW9uKCkuICBmZDQ2YTAwNjRh
ZjEgKCJpMmM6CmNvbnZlcnQgaTJjLWlzY2ggdG8gcGxhdGZvcm1fZGV2aWNlIikgcmVtb3ZlZCB0
aGUgdXNlIG9mCmFjcGlfY2hlY2tfcmVnaW9uKCkgYnV0IG5vdCB0aGUgaW5jbHVkZS4KClJlbW92
ZSB0aGUgbm93LXVubmVjZXNzYXJ5IGluY2x1ZGUgb2YgPGxpbnV4L2FjcGkuaD4uICBObyBmdW5j
dGlvbmFsIGNoYW5nZQppbnRlbmRlZC4KCkZpeGVzOiBmZDQ2YTAwNjRhZjEgKCJpMmM6IGNvbnZl
cnQgaTJjLWlzY2ggdG8gcGxhdGZvcm1fZGV2aWNlIikKU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KUmV2aWV3ZWQtYnk6IEplYW4gRGVsdmFyZSA8amRl
bHZhcmVAc3VzZS5kZT4KUmV2aWV3ZWQtYnk6IE11a2VzaCBPamhhIDxtb2poYUBjb2RlYXVyb3Jh
Lm9yZz4KLS0tCiBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2guYyB8IDEgLQogMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LWlzY2guYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaXNjaC5jCmluZGV4IDVjNzU0YmY2NTll
Mi4uZjY0YzFkNzJmNzNmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2gu
YworKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWlzY2guYwpAQCAtMzAsNyArMzAsNiBAQAog
I2luY2x1ZGUgPGxpbnV4L2lvcG9ydC5oPgogI2luY2x1ZGUgPGxpbnV4L2kyYy5oPgogI2luY2x1
ZGUgPGxpbnV4L2lvLmg+Ci0jaW5jbHVkZSA8bGludXgvYWNwaS5oPgogCiAvKiBTQ0ggU01CdXMg
YWRkcmVzcyBvZmZzZXRzICovCiAjZGVmaW5lIFNNQkhTVENOVAkoMCArIHNjaF9zbWJhKQotLSAK
Mi4yMS4wLjM5Mi5nZjhmNjc4NzE1OWUtZ29vZwoK
--000000000000cda31005857d26e9--
