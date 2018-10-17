QEMU Security Notices
=====================

This directory records all QEMU Security Notices that are issued.

Notices must only added to this directory once any embargo is lifted, since the
GIT repository is fully public.

Notices are written in XML in a file ``$YEAR/$NUM.xml`` eg ``2014/0001.xml``.
Assign numbers incrementally as new issues are reported.  More details on the
XML format can be found in `README-schema.rst``.

When a new notice is published for the first time, send the text rendering of
the notice to the ``qemu-devel@nongnu.org``

When backporting security fixes to ``stable-X.Y`` branches, update the notice
with details of the backported changeset hash.

When doing a formal stable release, update the notices included with the release
tag name.
