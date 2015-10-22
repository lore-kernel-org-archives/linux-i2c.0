From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Thu, 22 Oct 2015 02:27:40 -0700
Message-ID: <20151022092740.GA28031@cumulusnetworks.com>
References: <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
 <20151020125111.GJ1526@lahna.fi.intel.com>
 <20151020174959.GA14829@cumulusnetworks.com>
 <20151021081231.GQ1526@lahna.fi.intel.com>
 <20151021082116.GA5635@cumulusnetworks.com>
 <20151021083406.GU1526@lahna.fi.intel.com>
 <20151021085241.GA5949@cumulusnetworks.com>
 <20151021090849.GW1526@lahna.fi.intel.com>
 <20151021092508.GB5949@cumulusnetworks.com>
 <CAJZ5v0js30rwaDrROaUsuyw+95YNqjfqR+kj4AvGRw8FfGXDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0js30rwaDrROaUsuyw+95YNqjfqR+kj4AvGRw8FfGXDEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu Oct 22 00:39, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Oct 21, 2015 at 11:25 AM, Dustin Byford
> <dustin@cumulusnetworks.com> wrote:
> > On Wed Oct 21 12:08, Mika Westerberg wrote:
> >> I don't really have strong feelings whether it should be the I2C core or
> >> individual drivers setting the ACPI companion. However, it would be nice
> >> to match DT here and they assign their of_node per driver.
> >
> > OK with me, if we can convince Rafael this is a good idea, I'll send a
> > new revision with drivers setting the companion.
> 
> If you can guarantee that ACPI PM or anything like _DS or _SRS will
> never be invoked for the device objects that "inherit" the ACPI
> companion from their parent, it at least is not outright dangerous.

I'm hoping an ack from Mika will suffice, but please let me know if
there's something I can do to verify or help ensure this.

		--Dustin
