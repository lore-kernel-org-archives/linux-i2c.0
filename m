From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 0/2] at24: convert the binding document to yaml
Date: Mon, 30 Sep 2019 10:59:55 +0200
Message-ID: <20190930085957.2779-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The first patch converts the at24 DT binding to yaml. The second adds a new
compatible special case that's being used undocumented currently.

v1 -> v2:
- modified the compatible property: we now list all possible combinations and
  non-standard types with appropriate fallbacks to be as strict as possible
- minor changes to other properties: added constraints, converted to enums
  where applicable and referenced the types from schema

v2 -> v3:
(Rob Herring:)
- Here's my reworking of compatible schema and all the other fixes I
  found. The inner 'oneOf' is probably a little excessive given the number
  of lines. All it does is ensure both compatible strings have the same
  part number.

v3 -> v4:
- Add a $nodename definition
- Turns out the compatible schema is too complex for generating a 'select'
  schema and only a small subset where getting validated. So we need a
  custom 'select' schema. This in turn fixes the issue with the nxp,se97b
  binding.

v4 -> v5:
- added a new patch extending the list of special cases of the compatible
  property
- added comments explaining the schema for the compatible property
- dropped redundant information from property descriptions (for instance:
  there's no need to say "This parameterless property" where it's obvious
  from the type that the property is a flag)

Bartosz Golaszewski (2):
  dt-bindings: at24: convert the binding document to yaml
  dt-bindings: at24: add new compatible

 .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
 .../devicetree/bindings/eeprom/at24.yaml      | 182 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 184 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml

-- 
2.23.0
