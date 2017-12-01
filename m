From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1=2F1=5D_at24=3A_Fix_I=C2=B2C_device_selection_for_?=
        =?UTF-8?Q?runtime_PM?=
Date: Fri, 1 Dec 2017 12:59:40 -0500
Message-ID: <CAGngYiXfLyf1GoRtivUc5Z2qxFCa-z_-ryy6spQ_3JJK8zt22w@mail.gmail.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com>
 <20171130223524.31716-1-sakari.ailus@linux.intel.com> <CAGngYiUktfXOU64Uo-O=01OWJrT8fQ7icxS6m4mQO+6UAkGUsA@mail.gmail.com>
 <20171201153538.fgwc4h4lbgnhabs3@paasikivi.fi.intel.com> <CAMRc=Me6b7aRWFg-DPtNq5TKNwwr_oRO8ip7Nn9LosivOZKjGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36320 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdLAR7l (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 12:59:41 -0500
In-Reply-To: <CAMRc=Me6b7aRWFg-DPtNq5TKNwwr_oRO8ip7Nn9LosivOZKjGA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, Sven Van Asbroeck <svendev@arcx.com>, linux-kernel@vger.kernel.org, divagar.mohandass@intel.com

Bartosz wrote:
> Could you take a look if my rebase didn't break anything?

Unfortunately the rebase broke multi-address eeprom support ;(

I will post a corrected patch.
