From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c: move locking operations to their own struct
Date: Wed, 24 Aug 2016 09:47:19 +0200
Message-ID: <4ff4bdab-a322-8cf2-aec8-bfd4ae4c2f34@axentia.se>
References: <1469780277-31085-1-git-send-email-peda@axentia.se>
 <1469780277-31085-3-git-send-email-peda@axentia.se>
 <20160823211600.GF20872@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:59200
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752094AbcHXICi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Aug 2016 04:02:38 -0400
In-Reply-To: <20160823211600.GF20872@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On 2016-08-23 23:16, Wolfram Sang wrote:
> On Fri, Jul 29, 2016 at 10:17:57AM +0200, Peter Rosin wrote:
>> This makes it trivial to constify them, so do that.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Looks good. Could you rebase to i2c/for-next?

Right, no problem!

Cheers,
Peter

The following changes since commit 00f0ea70d2b82b7d7afeb1bdedc9169eb8ea6675:

  eeprom: at24: check if the chip is functional in probe() (2016-08-22 08:19:58 +0200)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-lock-op

for you to fetch changes up to 4b42b8c2e3233671e49deee71458edb6737a38bf:

  i2c: move locking operations to their own struct (2016-08-24 06:38:58 +0200)

----------------------------------------------------------------
Peter Rosin (2):
      i2c: add i2c_trylock_bus wrapper, use it
      i2c: move locking operations to their own struct

 drivers/i2c/i2c-core.c | 15 +++++++++------
 drivers/i2c/i2c-mux.c  | 29 ++++++++++++++++++-----------
 include/linux/i2c.h    | 37 +++++++++++++++++++++++++++++++------
 3 files changed, 58 insertions(+), 23 deletions(-)
