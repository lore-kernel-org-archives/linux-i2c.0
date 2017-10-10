From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] i2c-xlp9xx: update i2c driver to handle
 I2C_M_RECV_LEN flag
Date: Wed, 11 Oct 2017 01:35:10 +0200
Message-ID: <CAJZ5v0gz9FQMXhiBokOKY5esrmv2JNoScsv5-LNR2ui_CZPdAQ@mail.gmail.com>
References: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507616876-17189-1-git-send-email-kamlakant.patel@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kamlakant Patel <kamlakant.patel@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 10, 2017 at 8:27 AM, Kamlakant Patel
<kamlakant.patel@cavium.com> wrote:
> This patch set has following changes:
>  * Use Linux clk APIs to get input clock frequency for the I2C controller.
>  * I2C driver update to handle I2C_M_RECV_LEN and I2C_CLIENT_PEC flags.
>
> Changes since v1:
> * Rebased to mainline(4.14-rc4).
> * Removed unnecessary parens in i2c-xlp9xx.c.
>
> Jayachandran C (2):
>   ACPI / APD: Add clock frequency for ThunderX2 I2C controller
>   i2c: xlp9xx: Get clock frequency with clk API
>
> Kamlakant Patel (1):
>   i2c: xlp9xx: Handle I2C_M_RECV_LEN in msg->flags
>
>  drivers/acpi/acpi_apd.c         |  5 +++++
>  drivers/i2c/busses/i2c-xlp9xx.c | 44 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 45 insertions(+), 4 deletions(-)

Hi Wolfram,

I'm assuming that this will go in via the i2c tree, so please let me
know if anything is needed from my side.

Thanks,
Rafael
