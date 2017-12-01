From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1=2F1=5D_at24=3A_Fix_I=C2=B2C_device_selection_for_?=
        =?UTF-8?Q?runtime_PM?=
Date: Fri, 1 Dec 2017 10:20:41 -0500
Message-ID: <CAGngYiUktfXOU64Uo-O=01OWJrT8fQ7icxS6m4mQO+6UAkGUsA@mail.gmail.com>
References: <1512068603-12378-1-git-send-email-svendev@arcx.com> <20171130223524.31716-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:44347 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdLAPUm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Dec 2017 10:20:42 -0500
In-Reply-To: <20171130223524.31716-1-sakari.ailus@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, svendev@arcx.com, linux-kernel@vger.kernel.org, divagar.mohandass@intel.com, brgl@bgdev.pl

Thank you, it fixes the issue on the multi-address eeprom that I have access to.

Tested-by: Sven Van Asbroeck on a 24AA16/24LC16B <svendev@arcx.com>

One very minor remark:

+       struct device *dev = &at24->client[0]->dev;

It is sufficiently clear to others (and us a few months down the line)
why we are
using only client[0] for power management? Could it benefit from a separate
function with comments?

struct device *dev = get_pm_device(at24);

static struct device *get_pm_device(struct at24_data *at24)
{
    /* explain why we use client[0] and not any of the dummies */
    return &at24->client[0]->dev;
}
