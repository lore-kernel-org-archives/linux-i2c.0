From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 2/4] i2c: busses: xgene: add acpi support for i2c xgene SLIMpro driver
Date: Fri, 24 Apr 2015 09:28:40 +0200
Message-ID: <17062291.7gO4LEY2iX@wuerfel>
References: <1429812430-31631-1-git-send-email-fkan@apm.com> <1429812430-31631-3-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429812430-31631-3-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Feng Kan <fkan@apm.com>, patches@apm.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 23 April 2015 11:07:08 Feng Kan wrote:
> 
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
> +       {"PRP0001", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
> +#endif
> 

Sorry, but this is wrong: The PRP0001 name is meant for embedded
devices that just use the generic properties API for loading, and
does not require specifying an ACPI device ID.

	Arnd
