From: Sasha Levin <sashal@kernel.org>
Subject: Re: [4.9/4.14 patch v2 0/2] at24: add support for 24c2048
Date: Sun, 17 Feb 2019 12:13:45 -0500
Message-ID: <20190217171345.GD10616@sasha-vm>
References: <20190217111452.6152-1-bunk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217111452.6152-1-bunk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: stable@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 17, 2019 at 01:14:50PM +0200, Adrian Bunk wrote:
>There are some changes in the driver that prevent a direct
>cherry-pick to older kernels, including requiring only one
>line addition in the backport while the upstream commit
>requires three.
>
>Backport applies and builds against 4.9/4.14 (but not 4.4).
>Confirmed working with 4.14.
>For 4.19/4.20 please cherry-pick the upstream commits instead.
>
>Adrian Bunk (2):
>  dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
>  eeprom: at24: add support for 24c2048
>
> Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++--
> drivers/misc/eeprom/Kconfig                         | 2 +-
> drivers/misc/eeprom/at24.c                          | 1 +
> 3 files changed, 5 insertions(+), 3 deletions(-)

Queued for 4.14 and 4.9, thank you.
