From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v4] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Thu, 19 May 2016 11:45:46 +0200
Message-ID: <20160519114546.65433c59@endymion>
References: <1463143555-20261-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1463143555-20261-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

On Fri, 13 May 2016 15:45:55 +0300, Mika Westerberg wrote:
> +	if (function == ACPI_READ)
> +		status = acpi_os_read_port(address, (u32 *)value, bits);
> +	else
> +		status = acpi_os_write_port(address, (u32)*value, bits);

Jeremy McNicoll at RedHat brought to my attention that this may not be
safe. This assumes that function is either exactly ACPI_READ or exactly
ACPI_WRITE. However function is a 32-bit bitfield if I understand
correctly.

Shouldn't it instead be:

	if ((function & ACPI_IO_MASK) == ACPI_READ)

as drivers exfldio, acpi_ipmi and i2c-core do? Maybe it makes no
difference if other bits are never used, but maybe they will be in the
future.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
