#!/bin/bash
# Build script that injects environment variables into owner-config.js

# Use environment variables if set, otherwise use defaults
# The fake-auth-v2.js has its own fallbacks, so these defaults are safe
OWNER_EMAIL_VALUE="${OWNER_EMAIL:-owner@example.com}"
OWNER_PASSWORD_VALUE="${OWNER_PASSWORD:-change-me}"

if [ -z "$OWNER_EMAIL" ] || [ -z "$OWNER_PASSWORD" ]; then
  echo "Note: OWNER_EMAIL and/or OWNER_PASSWORD not set, using defaults"
fi

# Create owner-config.js with environment variable values
cat > owner-config.js << EOF
// Owner Configuration - Generated at build time
const OWNER_EMAIL = '${OWNER_EMAIL_VALUE}';
const OWNER_PASSWORD = '${OWNER_PASSWORD_VALUE}';

// Make available to other scripts
if (typeof window !== 'undefined') {
  window.OWNER_EMAIL = OWNER_EMAIL;
  window.OWNER_PASSWORD = OWNER_PASSWORD;
}
EOF

echo "owner-config.js generated successfully"
