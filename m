From: Frank Rowand <frowand.list@gmail.com>
Subject: portable device tree connector -- problem statement
Date: Mon, 4 Jul 2016 13:58:53 -0700
Message-ID: <577ACE0D.9050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33770 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbcGDU7E (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Jul 2016 16:59:04 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, david@gibson.dropbear.id.au, stephen.boyd@linaro.org, broonie@kernel.org, grant.likely@secretlab.ca, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com

Hi Pantelis,

As I have been trying to understand the proposal for a portable device
tree connector, I am starting to appreciate the possible complexity of
the problem you are trying to solve.  I suspect that the details of the
problem space are something you know a lot about and take for granted.
On the other hand, I have no previous detailed knowledge of the beagle
family.

This means that I do not have a functional requirements model to
evaluate proposals against.

The following might or might not be correct, but it is the type
of information that would help create a functional requirements
model:

1) There are several different beaglebone boards
    - beaglebone, several versions  (does not have P8, P9,
      so not relevant?)
    - beaglebone (at least 6 revisions)
    - beaglebone black (at least 10 revisions)
    - beaglebone green (adds Grove connectors)
    - could be others, I don't know

2) The different beaglebones all have two expansion
   connectors?
    - all connectors have the same physical specification?
    - the pinout of the same connectors (P8 and P9)
      - is the same on all beaglebones?
      - is different on different beaglebones?
      - there is a small number of different pinouts?
      - there is a large number of different pinouts?
    - for bones with the same pinout:
      - the pins are routed to different function blocks on the
        SOC because different bones may have different SOCs?
        - the different functional blocks are compatible or not?
      - the pins are routed to different function blocks on the
        SOC, even though different bones have the same SOC,
        because that is a design decision by the bone designer?
    - for bones with a different pinout:
      - is there an overlap with the pinout of other bones, with
        just some of the pins having a different definition?

There are a lot of potential functional requirements based on
the above questions.  This is not meant to be anywhere near
exhaustive, just illustrative.

1) Provide an interface definition that allows a single cape
P8 definition to work on different versions of host board,
where the pinout is consistent across the bones, and the
routing of signals between the SOC (and other chips) to
the P8 connector is consistent.

2) Provide an interface definition that allows a single cape
   P8 definition to work on different versions of host board,
   where the pinout is consistent across the bones, but the
   routing of signals between the SOC (and other chips) to
   the P8 connector differs.

   1a) Same as "1)", but for P9.
   1b) Same as "1)", but for both P8 and P9.

3) Provide an interface definition that allows a single cape
   P8 definition that only uses a specified subset of the P8
   pins to work on different versions of the host board, where
   the pinout of the specified subset is consistent across the
   bones.

   2a) Same as "2)", but for P9.
   2b) Same as "2)", but for both P8 and P9.

4) Provide an interface definition that requires a different
   cape definition for different versions of host board.

Again, there are more possible variations on what functional
requirements might be useful to support in a portable device
tree connector.  I was just trying to provide a flavor of
what I am looking for.

Is the problem statement and an explanation of the underlying
constraints that lead to the problem statement available?

Thanks,

Frank
