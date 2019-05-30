From: David Miller <davem@davemloft.net>
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Date: Thu, 30 May 2019 11:27:59 -0700 (PDT)
Message-ID: <20190530.112759.2023290429676344968.davem@davemloft.net>
References: <20190528230233.26772-1-ruslan@babayev.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528230233.26772-1-ruslan@babayev.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ruslan@babayev.com
Cc: mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>
Date: Tue, 28 May 2019 16:02:31 -0700

> Changes:
> v2:
> 	- more descriptive commit body
> v3:
> 	- made 'i2c_acpi_find_adapter_by_handle' static inline
> v4:
> 	- don't initialize i2c_adapter to NULL. Instead see below...
> 	- handle the case of neither DT nor ACPI present as invalid.
> 	- alphabetical includes.
> 	- use has_acpi_companion().
> 	- use the same argument name in i2c_acpi_find_adapter_by_handle()
> 	  in both stubbed and non-stubbed cases.

Series applied.
