From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [RFC/PATCH 0/4] New style overlay and /expansion/ support
Date: Mon, 30 Jan 2017 16:02:55 -0800
Message-ID: <20170131000259.28576-1-stephen.boyd@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35979 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbdAaAEB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Jan 2017 19:04:01 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so95608607pfu.3
        for <linux-i2c@vger.kernel.org>; Mon, 30 Jan 2017 16:03:02 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: devicetree-compiler@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

This series revives the new style of overlay syntax that never got
merged. David said he wanted to handle it outside of the parse
phase[1], and he proposed a patch to move overlay application to the
livetree phase. I've applied that patch and reworked Pantelis' last
two patches for the new style "syntactic sugar" on top[2].

In addition, I've included the new /expansion/ keyword support for
overlays that don't reference any labels that are outside of the
input file. The new expansion keyword just transforms the unresolved
references into strings that go into a new 'target-alias' property
instead of the 'target' property. This is in line with what David
has proposed on the mailing list a few months ago[3].

RFC part: The current syntax requires a root node or overlays are rejected.
Making the root node optional would require some non-trivial rework of the
grammar to support it. This means the proposed 'new style' syntax doesn't
work without the root node.

[1] https://lkml.kernel.org/r/20161125041124.GB12287@umbus.fritz.box
[2] https://lkml.kernel.org/r/1481114903-8197-7-git-send-email-pantelis.antoniou@konsulko.com
[3] https://lkml.kernel.org/r/20160718142037.GS16769@voom.fritz.box

David Gibson (1):
  Start moving overlay handling from parser into dtc core

Pantelis Antoniou (1):
  tests: Add a test for overlays syntactic sugar

Stephen Boyd (2):
  dtc: Add syntactic sugar version of overlays
  dtc: Add /expansion/ support

 checks.c                         |  2 +-
 dtc-lexer.l                      |  6 +++
 dtc-parser.y                     | 68 +++++++++++++++++-----------------
 dtc.c                            | 16 +++++++-
 dtc.h                            | 20 +++++++++-
 flattree.c                       |  2 +-
 fstree.c                         |  2 +-
 livetree.c                       | 80 +++++++++++++++++++++++++++++++++++++++-
 tests/overlay_overlay_simple.dts |  3 ++
 tests/run_tests.sh               |  6 +++
 10 files changed, 163 insertions(+), 42 deletions(-)

-- 
2.10.0.297.gf6727b0
