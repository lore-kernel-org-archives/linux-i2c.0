From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 22/57] drivers: i2c: Use generic helper to match
 device by acpi_dev
Date: Tue, 4 Jun 2019 12:27:20 +0300
Message-ID: <20190604092720.GO2781@lahna.fi.intel.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-23-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1559577023-558-23-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:48PM +0100, Suzuki K Poulose wrote:
> Switch to the generic helper to match device by acpi_dev.

It would be nice if you had Cc'd actual implementation of
device_match_acpi_dev() as well but if it looks like
i2c_acpi_find_match_device() then this is fine by me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
