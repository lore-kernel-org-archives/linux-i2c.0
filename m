From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] acpi: add acpi_preset_companion() stub
Date: Sun, 25 Oct 2015 16:01:53 +0100
Message-ID: <5592418.OvKTBkBvLd@vostro.rjw.lan>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com> <1445505462-27915-2-git-send-email-dustin@cumulusnetworks.com> <CAJZ5v0h_u0F_9vXHDT458+qvU0J8jwi0tXWfbLcOtYhDJPQJ_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h_u0F_9vXHDT458+qvU0J8jwi0tXWfbLcOtYhDJPQJ_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dustin Byford <dustin@cumulusnetworks.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Sunday, October 25, 2015 02:40:10 PM Rafael J. Wysocki wrote:
> On Thu, Oct 22, 2015 at 11:17 AM, Dustin Byford
> <dustin@cumulusnetworks.com> wrote:
> > Add a stub for acpi_preset_companion().  Fixes build failures when
> > acpi_preset_companion() is used and CONFIG_ACPI is not set.
> >
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> > ---
> >  include/linux/acpi.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 51a96a8..66564f8 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -505,6 +505,12 @@ static inline bool has_acpi_companion(struct device *dev)
> >         return false;
> >  }
> >
> > +static inline void acpi_preset_companion(struct device *dev,
> > +                                        struct acpi_device *parent, u64 addr)
> > +{
> > +       return;

But of course, the version without the return statement here is better.

> > +}
> > +
> >  static inline const char *acpi_dev_name(struct acpi_device *adev)
> >  {
> >         return NULL;

Thanks,
Rafael
