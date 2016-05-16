From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/5]  of: dynamic: Changesets helpers & fixes
Date: Mon, 16 May 2016 19:41:23 +0300
Message-ID: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patchset introduces changeset helpers which makes working with
changeset much easier and less error prone.

The first patch exports an internal method which is used for the third patch
which contains the bulk of the changes.

The second introduces a of_changeset_node_move method that helps when
moving subtrees.

The third contains the changesets unittests.

The final patch converts an in-kernel user to the helpers.

Finally the last patch adds a unittest for the changeset helpers.

Changes since v1:
* Dropped accepted patch
* Addressed maintainer comments
* Made a lot of methods that made sense into static inlines.
* Split out of_changeset_node_move method into a seperate patch
* Add in-kernel conversion i2c-demux patch

Pantelis Antoniou (5):
  of: dynamic: Add __of_node_dupv()
  of: changesets: Introduce changeset helper methods
  of: changeset: Add of_changeset_node_move method
  of: unittest: changeset helpers
  i2c: demux: Use changeset helpers for clarity

 drivers/i2c/muxes/i2c-demux-pinctrl.c |   5 +-
 drivers/of/dynamic.c                  | 321 +++++++++++++++++++++++++++++++-
 drivers/of/unittest.c                 |  54 ++++++
 include/linux/of.h                    | 337 ++++++++++++++++++++++++++++++++++
 4 files changed, 708 insertions(+), 9 deletions(-)

-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
