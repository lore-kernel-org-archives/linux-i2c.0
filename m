From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 2/2] i2c: add ACPI support for I2C mux ports
Date: Fri, 23 Oct 2015 16:55:55 +0300
Message-ID: <562A3C6B.6070304@linux.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com> <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com> <1445505462-27915-3-git-send-email-dustin@cumulusnetworks.com> <20151023084013.GS1526@lahna.fi.intel.com> <20151023101611.GH13380@katana> <20151023131311.GA1526@lahna.fi.intel.com> <20151023134004.GB1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151023134004.GB1526@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

On 10/23/2015 04:40 PM, Mika Westerberg wrote:
> On Fri, Oct 23, 2015 at 04:13:11PM +0300, Mika Westerberg wrote:
>> On Fri, Oct 23, 2015 at 12:16:11PM +0200, Wolfram Sang wrote:
>>> On Fri, Oct 23, 2015 at 11:40:13AM +0300, Mika Westerberg wrote:
>>>> On Thu, Oct 22, 2015 at 02:17:42AM -0700, Dustin Byford wrote:
> Ah, forgot to mention that the i2c-designware-pcidrv.c misses include=
 of
> <linux/acpi.h> so that needs to be fixed. Otherwise we get:
>
> drivers/i2c/busses/i2c-designware-pcidrv.c: In function =E2=80=98i2c_=
dw_pci_probe=E2=80=99:
> drivers/i2c/busses/i2c-designware-pcidrv.c:259:2: error: implicit dec=
laration of function =E2=80=98ACPI_COMPANION_SET=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
> drivers/i2c/busses/i2c-designware-pcidrv.c:259:33: error: implicit de=
claration of function =E2=80=98ACPI_COMPANION=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
>
Please also check that patches apply on top of i2c/for-next due recentl=
y=20
applied cleanup patches from me.

I think commit d80d134182ba ("i2c: designware: Move common probe code=20
into i2c_dw_probe()") makes your patch only a 2 liner to=20
drivers/i2c/busses/i2c-designware-core.c :-)

--=20
Jarkko
