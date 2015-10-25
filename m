From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/2] acpi: add acpi_preset_companion() stub
Date: Sun, 25 Oct 2015 14:40:10 +0100
Message-ID: <CAJZ5v0h_u0F_9vXHDT458+qvU0J8jwi0tXWfbLcOtYhDJPQJ_Q@mail.gmail.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
	<1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
	<1445505462-27915-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445505462-27915-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 22, 2015 at 11:17 AM, Dustin Byford
<dustin@cumulusnetworks.com> wrote:
> Add a stub for acpi_preset_companion().  Fixes build failures when
> acpi_preset_companion() is used and CONFIG_ACPI is not set.
>
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/acpi.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 51a96a8..66564f8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -505,6 +505,12 @@ static inline bool has_acpi_companion(struct device *dev)
>         return false;
>  }
>
> +static inline void acpi_preset_companion(struct device *dev,
> +                                        struct acpi_device *parent, u64 addr)
> +{
> +       return;
> +}
> +
>  static inline const char *acpi_dev_name(struct acpi_device *adev)
>  {
>         return NULL;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
