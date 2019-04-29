From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH v2] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Mon, 29 Apr 2019 16:26:17 +0200
Message-ID: <20190429162617.3b936981@endymion>
References: <1556327264-31730-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556327264-31730-1-git-send-email-puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: bp@alien8.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 27 Apr 2019 09:07:44 +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
> which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
> to the i2c-piix4 driver by using the code path of AMD.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v1->v2:
>   - Remove the revision number checking for Hygon SMBus device.
>   - Document the new supported chipset in drivers/i2c/busses/Kconfig
>     and Documentation/i2c/busses/i2c-piix4 as well as in the header
> 	comment of i2c-piix4.c.
> 
>  Documentation/i2c/busses/i2c-piix4 |  2 ++
>  drivers/i2c/busses/Kconfig         |  1 +
>  drivers/i2c/busses/i2c-piix4.c     | 15 +++++++++++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> (...)

Looks good to me now, thanks.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
